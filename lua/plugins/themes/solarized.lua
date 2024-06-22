return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    opts = {
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "vista_kind", "terminal" },
      lualine_bold = true,
    },
  },
}
