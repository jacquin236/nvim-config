local icons = require("util.icons")
local symbols = require("lspkind").symbol_map
local lsp_kind = require("util.ui").lsp.highlights

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Load NeoTree if entering a directory",
        callback = function(args)
          if vim.fn.isdirectory(vim.api.nvim_buf_get_name(args.buf)) > 0 then
            require("lazy").load({ plugins = { "neo-tree.nvim" } })
            vim.api.nvim_del_autocmd(args.id)
          end
        end,
      })
    end,
    opts = function(_, opts)
      opts.source_selector = {
        winbar = true,
        separator_active = icons.separators.LeftThinBlock,
        sources = {
          { source = "filesystem" },
          { source = "git_status" },
          { source = "document_symbols" },
        },
        tabs_layout = "equal",
      }
      opts.enable_git_status = true
      opts.git_status_async = true
      opts.nesting_rules = {
        ["go"] = {
          pattern = "(.*)%.go$",
          files = { "%1_test.go" },
        },
        ["docker"] = {
          pattern = "^dockerfile$",
          ignore_case = true,
          files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
        },
      }
      opts.event_handlers = {
        {
          event = "neo_tree_popup_input_ready",
          handler = function()
            vim.cmd("stopinsert")
          end,
        },
      }
      opts.filesystem = {
        bind_to_cwd = false,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        group_empty_dirs = false,
        follow_current_file = { enabled = true, leave_dirs_open = true },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          never_show = { "_.DS_Store" },
        },
      }
      opts.default_component_configs = {
        icon = {
          folder_empty = icons.documents.OpenFolderEmpty,
        },
        name = { highlight_opened_files = true },
        document_symbols = {
          follow_cursor = true,
          kinds = vim.iter(symbols):fold({}, function(acc, k, v)
            acc[k] = { icon = v, hl = lsp_kind[k] } ---@diagnostic disable-line: no-unknown
            return acc
          end),
        },
        modified = { symbol = icons.misc.CircleSmall .. " " },
        git_status = {
          symbols = {
            added = icons.git.Added,
            deleted = icons.git.Removed,
            modified = icons.git.Modified,
            renamed = icons.git.Renamed,
            untracked = icons.git.Untracked,
            ignored = icons.git.IgnoredAlt,
            unstaged = icons.git.UnstagedAlt,
            staged = icons.git.Staged,
            conflict = icons.git.Conflict,
          },
        },
        file_size = { required_width = 50 },
        symlink_target = { enabled = true },
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      }
      opts.window = {
        mappings = {
          ["o"] = "toggle_node",
          ["<cr>"] = "open_with_window_picker",
          ["P"] = { "toggle_preview", config = { use_float = false } },
          ["<esc>"] = "revert_preview",
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
