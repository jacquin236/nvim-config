return {
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      link_highlights = false,
      autocmd = { enabled = true },
      sign = {
        enabled = true,
        text = "💡",
      },
      float = {
        enabled = true,
        text = "💡",
        win_opts = {
          winblend = 0,
        },
      },
    },
    config = function(_, opts)
      require("nvim-lightbulb").setup(opts)
    end,
  },
}
