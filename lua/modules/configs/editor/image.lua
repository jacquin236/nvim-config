return {
  {
    "3rd/image.nvim",
    opts = {
      integrations = {
        markdown = {
          enabled = true,
          download_remote_images = true,
          filetypes = { "markdown", "vimwiki", "quarto", "python" },
        },
        neorg = {
          enabled = true,
          download_remote_images = true,
          filetypes = { "norg", "org" },
        },
      },
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
