local function find_debugpy_python_path()
  local notifications = require("util.py-options").notifications.python

  if vim.env.VIRTUAL_ENV then
    local paths = vim.fn.glob(vim.env.VIRTUAL_ENV .. "/**/debugpy", true, true)
    if table.concat(paths, ", ") ~= "" then
      local venv_path = vim.env.VIRTUAL_ENV .. "/bin/python"
      notifications.debugpy.path = venv_path
      return venv_path
    end
  end

  local mason_registry = require("mason-registry")
  local mason_path = mason_registry.get_package("debugpy"):get_install_path() .. "/venv/bin/python"
  if mason_path then
    notifications.debugpy.path = mason_path
    notifications.debugpy.warn = true
    return mason_path
  end

  return nil
end

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "debugpy" })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap_python = require("dap-python")
      local debugpy_path = find_debugpy_python_path()
      dap_python.setup(debugpy_path)
    end,
  },
}
