return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = true,
      },
      contrast = "hard",
      strikethrough = true,
      inverse = false,
      dim_inactive = false,
      transparent_mode = vim.g.transparent_enabled,
    })
  end,
}
