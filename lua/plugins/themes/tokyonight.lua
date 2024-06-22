return {
  "folke/tokyonight.nvim",
  lazy = true,
  priority = 1000,
  opts = {
    style = "night",
    light_style = "moon",
    transparent = false,
    terminal_colors = true,
    styles = {
      --sidebars = "transparent",
      --floats = "transparent",
      comments = { italic = true },
      keywords = { italic = false, bold = true },
      variables = { italic = true },
    },
    hide_inactive_statusline = true,
    sidebars = { "qf", "help", "vista_kind", "spectre_panel" },
    lualine_bold = true,
    dim_inactive = true,
  },
}
