return {
	"mxsdev/nvim-dap-vscode-js",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	dependencies = { "mfussenegger/nvim-dap" },
	opts = {
		adapters = { "chrome", "pwa-node", "pwa-chrome", "node-terminal", "pwa-extensionHost" },
		node_path = "node",
		debugger_cmd = { "js-debug-adapter" },
	},
	config = function(_, opts)
		require("dap-vscode-js").setup(opts)
		for _, language in ipairs({ "typescrip", "typescriptreact", "javascript", "javascriptreact" }) do
			require("dap").configurations[language] = {
				{
					type = "chrome",
					request = "launch",
					name = "Launch Chrome against localhost",
					url = "https://localhost:3000",
					webRoot = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
	end,
}
