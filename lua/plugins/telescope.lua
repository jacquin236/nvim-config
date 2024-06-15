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
    keys = {
      {
        "<localleader>p",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<localleader>l",
        function()
          local files = {} ---@type table<string, string>
          for _, plugin in pairs(require("lazy.core.config").plugins) do
            repeat
              if plugin._.module then
                local info = vim.loader.find(plugin._.module)[1]
                if info then
                  files[info.modpath] = info.modpath
                end
              end
              plugin = plugin._.super
            until not plugin
          end
          require("telescope.builtin").live_grep({ default_text = "/", search_dirs = vim.tbl_values(files) })
        end,
        desc = "Find Lazy Plugin Spec",
      },
    },
  },
}
