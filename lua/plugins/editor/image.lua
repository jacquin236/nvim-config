return {
  {
    "3rd/image.nvim",
    lazy = true,
    ft = { "markdown", "vimwiki" },
    opts = {
      integrations = { markdown = { filetypes = { "markdown", "vimwiki" } } },
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  {
    "edluffy/hologram.nvim",
    lazy = true,
    config = function()
      require("hologram").setup({
        auto_display = true,
      })
    end,
  },
}
