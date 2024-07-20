local actions = require("telescope.actions")

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
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<S-esc>"] = actions.close,
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            ["<c-l>"] = require("telescope.actions.layout").cycle_layout_next,
            ["<a-l>"] = require("telescope.actions.layout").cycle_layout_prev,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-Tab>"] = require("telescope.actions").select_tab_drop,
            ["<M-h>"] = require("telescope.actions").results_scrolling_left,
            ["<M-l>"] = require("telescope.actions").results_scrolling_right,
          },
        },
        file_ignore_patterns = {
          ".gitignore",
          "node_modules",
          "build",
          "dist",
          "yarn.lock",
          "*.git/*",
          "*/tmp/*",
        },
      },
      pickers = {
        find_files = {
          hidden = false,
        },
        buffers = {
          layout_config = {
            prompt_position = "top",
            height = 0.5,
            width = 0.6,
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<c-r>"] = require("telescope.actions").delete_buffer,
            },
          },
        },
        spell_suggest = {
          layout_config = {
            prompt_position = "top",
            height = 0.3,
            width = 0.25,
          },
          sorting_strategy = "ascending",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    },
  },
}
