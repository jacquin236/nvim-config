return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
          horizontal = { preview_width = { 0.7, max = 100, min = 30 } },
          vertical = { preview_cutoff = 20, preview_height = 0.85 },
          cursor = { height = 0.5, width = 0.8 },
        },
        sorting_strategy = "ascending",
        path_display = { filename_first = { reverse_directories = false } },
        dynamic_preview_title = true,
        winblend = 0,
      },
      pickers = {
        buffers = {
          theme = "dropdown",
          mappings = {
            i = {
              ["<C-d>"] = require("telescope.actions").delete_buffer,
            },
          },
        },
        current_buffer_fuzzy_find = { layout_strategy = "vertical" },
        grep_string = { layout_strategy = "vertical" },
        lsp_references = { layout_strategy = "vertical" },
        lsp_definitions = { layout_strategy = "vertical" },
        lsp_type_definitions = { layout_strategy = "cursor" },
        lsp_implementations = { layout_strategy = "cursor" },
      },
    },
  },
}
