return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = { enabled = true, suggestions = 9 } },
      window = {
        border = "single",
        position = "bottom",
        margin = { 2, 2, 2, 2 },
        padding = { 1, 0, 1, 0 },
        winblend = 0,
      },
      layout = {
        spacing = 1,
        align = "center",
      },
    },
  },
}
