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
        enabled = false,
      },
    },
    config = function(_, opts)
      require("nvim-lightbulb").setup(opts)
    end,
  },
}
