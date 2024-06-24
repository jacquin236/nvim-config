return {
  {
    "3rd/image.nvim",
    lazy = true,
    ft = { "markdown", "vimwiki" },
    opts = {
      integrations = {
        markdown = {
          enabled = true,
          filetypes = { "markdown", "vimwiki" }
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
        html = { enabled = true },
        css = { enabled = true },
      },
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },
}
