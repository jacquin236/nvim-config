return {
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = {
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      node_path = "node",
    },
    config = function(_, opts)
      require("dap-vscode-js").setup(opts)

      local languages = { "typescript", "typescriptreact", "javascript" }
      for _, language in ipairs(languages) do
        local dap = require("dap")
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
