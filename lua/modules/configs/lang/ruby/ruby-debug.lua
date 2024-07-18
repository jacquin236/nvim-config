return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "suketa/nvim-dap-ruby",
        config = function()
          require("dap-ruby").setup()
        end,
      },
    },
    opts = function()
      local dap = require("dap")
      dap.adapters.ruby = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "bundle",
          args = {
            "exec",
            "rdbg",
            "-n",
            "--open",
            "--port",
            "${port}",
            "-c",
            "--",
            "bundle",
            "exec",
          },
        },
      }

      dap.configurations.ruby = {
        {
          type = "ruby",
          name = "Debug current file",
          request = "attach",
          localfs = true,
          command = "ruby",
          script = "${file}",
        },
        {
          type = "ruby",
          name = "Run current spec file",
          request = "attach",
          localfs = true,
          command = "rspec",
          script = "${file}",
        },
      }
    end,
  },
}
