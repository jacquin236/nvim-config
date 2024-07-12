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
      debugger_cmd = { "js-debug-adapter" },
    },
    config = function(_, opts)
      require("dap-vscode-js").setup(opts)

      local languages = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
      for _, language in ipairs(languages) do
        local dap = require("dap")
        dap.configurations[language] = {

          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-msedge",
            request = "launch",
            name = "Start Edge against localhost",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            console = "integratedTerminal",
            sourceMaps = true,
            program = "${file}",
          },
        }
      end
    end,
  },
}
