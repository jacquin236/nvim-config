return {
  "navarasu/onedark.nvim",
  lazy = false,
  opts = {
    style = "deep",
    term_colors = true,
    transparent = false,
    cmp_itemkind_reverse = false,
    toggle_style_list = {
      "dark",
      "darker",
      "cool",
      "warm",
      "warmer",
      "deep",
      "light",
    },
    code_style = {
      comments = "italic",
      keywords = "italic",
      functions = "none",
      strings = "none",
      variables = "none",
    },
    lualine = {},
    diagnostic = { darker = true, undercurl = true, background = false },
  },
}
