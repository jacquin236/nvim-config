return {
	{
		"rcarriga/nvim-dap-ui",
		opts = {
			windows = { indent = 2 },
			floating = { border = require("util.ui").border },
			layouts = {
				{
					elements = {
						{ id = "scopes",      size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks",      size = 0.25 },
						{ id = "watches",     size = 0.25 },
					},
					position = "right",
					size = 20,
				},
				{ elements = { { id = "repl", size = 0.9 } }, position = "bottom", size = 10 },
			},
		},
	},
}
