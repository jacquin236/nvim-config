-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Disable leader and localleader for some filetypes
autocmd("FileType", {
  group = augroup("lazyvim_unbind_leader_key", { clear = true }),
  pattern = {
    "lazy",
    "mason",
    "lspinfo",
    "toggleterm",
    "null-ls-info",
    "neo-tree-popup",
    "TelescopePrompt",
    "notify",
    "floaterm",
  },
  callback = function(event)
    vim.keymap.set("n", "<leader>", "<nop>", { buffer = event.buf, desc = "" })
    vim.keymap.set("n", "<localleader>", "<nop>", { buffer = event.buf, desc = "" })
  end,
})

-- Do not list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Plain terminals
autocmd("TermOpen", {
  pattern = "term://*",
  command = [[setlocal listchars= nonumber norelativenumber | startinsert]],
})

-- markdown file
autocmd("FileType", {
  pattern = "markdown",
  callback = function(event)
    vim.schedule(function()
      require("noice.text.markdown").keys(event.buf)
    end)
  end,
})

-- autowrap on text-based file
autocmd("FileType", {
  pattern = { "text", "tex", "markdown", "rst", "norg", "org" },
  callback = function()
    vim.wo.wrap = true
  end,
})

-- show cursorline only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- indent line (non-blankline only)
autocmd("OptionSet", {
  pattern = { "list" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lead = "│"
    for i = 1, vim.bo[bufnr].tabstop - 1 do
      lead = lead .. " "
    end
    vim.opt_local.listchars:append({ leadmultispace = lead })
  end,
})

-- Disable next line comments
autocmd("BufEnter", {
  callback = function()
    vim.cmd("set formatoptions-=cro")
    vim.cmd("setlocal formatoptions-=cro")
  end,
})
------------------------------------------------- Colors Helpers -------------------------------------------
local function mod_hl(opts, hl_names)
  for _, hl in ipairs(hl_names) do
    local hl_def = vim.api.nvim_get_hl(0, { name = hl })
    for k, v in pairs(opts) do
      hl_def[k] = v
    end
    local ok, _ = pcall(vim.api.nvim_set_hl, 0, hl, hl_def)
    if not ok then
      vim.pretty_print("Failed to set highlight " .. hl)
    end
  end
end

local update_highlight = function()
  mod_hl({ bold = true, italic = true }, {
    "@type.builtin",
    "@module.builtin",
    "@constant.builtin",
    "@function.builtin",
    "@variable.builtin",
    "@variable.parameter.builtin",
    "@boolean",
  })
  mod_hl({ bold = true }, {
    "@type",
    "@constructor",
  })
  mod_hl({ italic = true }, {
    "@comment",
    "@variable.parameter",
  })

  if not LazyVim.ui.color("IlluminatedWordText", true) and LazyVim.ui.color("LSPReferenceText", true) then
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LSPReferenceText" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LSPReferenceText" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LSPReferenceText" })
  end
  vim.cmd([[
      " highlight! Folded guibg=NONE
      highlight! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE
      ]])
end

autocmd(
  { "ColorScheme", "SessionLoadPost" },
  { group = vim.api.nvim_create_augroup("Color", {}), callback = update_highlight }
)
autocmd({ "BufReadPost" }, {
  group = vim.api.nvim_create_augroup("Color", { clear = false }),
  callback = update_highlight,
  once = true,
})

--------------------------------------- Python ------------------------------------------
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

autocmd({ "BufEnter", "BufWinEnter" }, {
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
