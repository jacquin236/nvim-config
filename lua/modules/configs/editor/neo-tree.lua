local icons = require "util.icons"

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "onsails/lspkind.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Neotree",
    config = function()
      require("neo-tree").setup {
        sources = {
          "filesystem",
          "git_status",
          "document_symbols",
        },
        source_selector = {
          winbar = true,
          separator_active = "",
          sources = {
            { source = "filesystem" },
            { source = "git_status" },
            { source = "document_symbols" },
          },
        },
        popup_border_style = "rounded",
        enable_git_status = true,
        git_status_async = true,
        nesting_rules = {
          ["go"] = {
            pattern = "(.*)%.go$",
            files = { "%1_test.go" },
          },
          ["docker"] = {
            pattern = "^dockerfile$",
            ignore_case = true,
            files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
          },
        },
        event_handlers = {
          {
            event = "neo_tree_popup_input_ready",
            handler = function()
              vim.cmd "stopinsert"
            end,
          },
        },
        filesystem = {
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
          group_empty_dirs = false,
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            never_show = { ".DS_Store", "thumbs.db" },
          },
          window = {
            mappings = {
              ["/"] = "noop",
              ["g/"] = "fuzzy_finder",
            },
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              -- Change type
              added = "✚",
              modified = "",
              deleted = "", -- this can only be used in the git_status source
              renamed = "󰁕", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󱥸",
              staged = "",
              conflict = "󰇸 ",
            },
          },
          icon = {
            folder_empty = icons.documents.FolderEmptyOpen,
            folder_closed = icons.documents.Folder,
            folder_open = icons.documents.FolderOpen,
          },
          modified = {
            symbol = icons.ui.Indicator,
          },
          file_size = { required_width = 50 },
          symlink_target = { enabled = true },
        },
        window = {
          mappings = {
            ["o"] = "toggle_node",
            ["<CR>"] = "open_with_window_picker",
            ["<c-s>"] = "split_with_window_picker",
            ["<c-v>"] = "vsplit_with_window_picker",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = false } },
          },
        },
      }
    end,
    keys = {
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute { source = "git_status", toggle = true }
        end,
        desc = "[git] explorer",
      },
    },
  },
}
