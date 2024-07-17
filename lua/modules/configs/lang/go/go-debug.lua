return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "delve" } },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      { "leoluz/nvim-dap-go", opts = {} },
    },
    opts = function()
      local dap = require("dap")
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug test (manually enter test name)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
          args = function()
            local testname = vim.fn.input("Test name (^regexp$ ok): ")
            return { "-test.run", testname }
          end,
        },
      }
    end,
  },
}
