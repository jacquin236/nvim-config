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
      opts.close_if_last_window = true
      opts.popup_border_style = "rounded"
      opts.use_popups_for_input = true
      opts.source_selector = {
        winbar = true,
        separator_active = "",
        sources = {
          { source = "filesystem", display_name = icons.documents.Folder .. " " .. "Files" },
          { source = "git_status", display_name = icons.git.Logo .. "  " .. "Git" },
          { source = "buffers",    display_name = icons.misc.List .. "  " .. "Buffers" },
        },
        content_layout = "center",
        tabs_layout = "equal",
        padding = 1,
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
          folder_open = icons.documents.OpenFolder,
          folder_closed = icons.documents.Folder,
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
        file_size = { enabled = true, required_width = 55 },
        symlink_target = { enabled = true },
        indent = {
          indent_size = 2,
          padding = 1,
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      }
      opts.window = {
        mappings = {
          ["e"] = "open",
          ["E"] = function()
            vim.api.nvim_exec("Neotree focus filesystem left", true)
          end,
          ["b"] = function()
            vim.api.nvim_exec("Neotree focus buffers left", true)
          end,
          ["g"] = function()
            vim.api.nvim_exec("Neotree focus git_status left", true)
          end,
          ["<c-/>"] = "fuzzy_finder_directory",
          ["D"] = function(state)
            local node = state.tree:get_node()
            local log = require("neo-tree.log")
            state.clipboard = state.clipboard or {}
            if diff_Node and diff_Node ~= tostring(node.id) then
              local current_Diff = node.id
              require("neo-tree.utils").open_file(state, diff_Node, open)
              vim.cmd("vert diffs " .. current_Diff)
              log.info("Diffing " .. diff_Name .. " against " .. node.name)
              diff_Node = nil
              current_Diff = nil
              state.clipboard = {}
              require("neo-tree.ui.renderer").redraw(state)
            else
              local existing = state.clipboard[node.id]
              if existing and existing.action == "diff" then
                state.clipboard[node.id] = nil
                diff_Node = nil
                require("neo-tree.ui.renderer").redraw(state)
              else
                state.clipboard[node.id] = { action = "diff", node = node }
                diff_Name = state.clipboard[node.id].node.name
                diff_Node = tostring(state.clipboard[node.id].node.id)
                log.info("Diff source file " .. diff_Name)
                require("neo-tree.ui.renderer").redraw(state)
              end
            end
          end,
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
