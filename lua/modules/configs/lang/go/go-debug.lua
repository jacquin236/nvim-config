return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "delve" } },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
    },
    opts = function()
      local dap = require("dap")
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
          -- add this if on windows, otherwise server won't open successfully
          -- detached = false
        },
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
      }
    end,
  },
}
