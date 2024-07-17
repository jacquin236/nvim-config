local function find_python_executable()
  local notifications = require("util.py-options").notifications.python

  if vim.env.VIRTUAL_ENV then
    local paths = vim.fn.glob(vim.env.VIRTUAL_ENV .. "/**/bin/python", true, true)
    local executable_path = table.concat(paths, ", ")
    if executable_path ~= "" then
      notifications.python3.path = executable_path
      return executable_path
    end
  elseif vim.fn.filereadable(".venv/bin/python") == 1 then
    local executable_path = vim.fn.expand(".venv/bin/python")
    notifications.python3.path = executable_path
    return executable_path
  else
    local global_path = vim.fn.exepath("python3")
    if global_path then
      notifications.python3.path = global_path
      notifications.python3.warn = true
      return global_path
    end
  end

  return nil
end

local function notify_tooling(lang)
  local notifications = require("util.py-options").notifications[lang]
  local infos = ""
  local warnings = ""
  local errors = ""
  for tool, info in pairs(notifications) do
    if type(info) == "table" then
      if info.path ~= nil then
        if info.warn == true then
          warnings = warnings
            .. "Using "
            .. tool
            .. " from Mason ("
            .. info.path
            .. "), consider installing it in your virtual environment.\n"
        else
          infos = infos .. "Using " .. tool .. ": " .. info.path .. "\n"
        end
      else
        errors = errors .. tool .. " not found.\n"
      end
    end
  end

  -- remove newline from end of strings
  infos = string.sub(infos, 1, -2)
  warnings = string.sub(warnings, 1, -2)
  errors = string.sub(errors, 1, -2)

  if infos ~= "" then
    vim.notify_once(infos, vim.log.levels.INFO)
  end
  if warnings ~= "" then
    vim.notify_once(warnings, vim.log.levels.WARN)
  end
  if errors ~= "" then
    vim.notify_once(errors, vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.py" },
  callback = function()
    local notifications = require("util.py-options").notifications.python

    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.colorcolumn = "88"
    if not vim.g.python3_host_prog then
      notifications.python3.path = find_python_executable()
      vim.g.python3_host_prog = notifications.python3.path
    end

    if not notifications._emitted then
      notify_tooling("python")
      notifications._emitted = true
    end
  end,
})
