local icons = require("util.icons").ui

return {
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      priority = 10,
      sign = {
        enabled = true,
        text = icons.CodeAction,
      },
      number = { enabled = true },
      autocmd = {
        enabled = true,
        updatetime = 50,
      },
      ignore = {
        ft = { "neo-tree" },
      },
    },
    config = function(_, opts)
      require("nvim-lightbulb").setup(opts)
    end,
  },
}
