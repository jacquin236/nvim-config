local function prefer_bin_from_venv(executable_name)
  -- Return the path to the executable if $VIRTUAL_ENV is set and the binary exists somewhere beneath the $VIRTUAL_ENV path, otherwise get it from Mason
  local notifications = require("util.py-options").notifications.python
  if vim.env.VIRTUAL_ENV then
    local paths = vim.fn.glob(vim.env.VIRTUAL_ENV .. "/**/bin/" .. executable_name, true, true)
    local venv_path = table.concat(paths, ", ")
    if venv_path ~= "" and venv_path ~= nil then
      notifications[executable_name].path = venv_path
      return venv_path
    end
  end

  local mason_registry = require("mason-registry")
  local mason_path = mason_registry.get_package(executable_name):get_install_path() .. "/bin/" .. executable_name
  if mason_path then
    notifications[executable_name].path = mason_path
    notifications[executable_name].warn = true
    return mason_path
  end

  local global_path = vim.fn.exepath(executable_name)
  if global_path then
    notifications[executable_name].path = global_path
    notifications[global_path].warn = true
    return global_path
  end

  return nil
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python", "ninja", "rst" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "ruff", "mypy" } },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local formatters = require("conform.formatters")
      local ruff_path = prefer_bin_from_venv("ruff")
      opts.formatters_by_ft.python = opts.formatters_by_ft.python or {}
      table.insert(opts.formatters_by_ft.python, "ruff_format")
      table.insert(opts.formatters_by_ft.python, "ruff_fix")

      if ruff_path then
        formatters.ruff_format.command = ruff_path
      end
      return opts
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local mypy_path = prefer_bin_from_venv("mypy")
      opts.linters_by_ft["python"] = { "mypy" }
      if mypy_path then
        opts.linters["mypy"] = {
          cmd = prefer_bin_from_venv("mypy"),
        }
      end
    end,
  },
}
