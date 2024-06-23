return {
  "folke/tokyonight.nvim",
  lazy = false,
  --priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = {},
        keywords = {},
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "vista_kind", "terminal" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = true,
      ---@diagnostic disable-next-line: undefined-field, no-unknown
      --- Override highlights group for better visual with transparent background
      on_highlights = function(highlights, colors)
        highlights.Comment = { fg = "#6e6ea3", italic = true }
        highlights.MatchParen = { fg = colors.magenta, bold = true }
        highlights.Special = { fg = "#ffd080" }
        highlights.Keyword = { fg = "#65bcff", italic = false, bold = true }
        highlights.String = { fg = "#c3e88d" }
        highlights.Character = { fg = "#4fd6be" }
        highlights.Function = { fg = "#fca7ea" }
      end,
    })
  end,
}
