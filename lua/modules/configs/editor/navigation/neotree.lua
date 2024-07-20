local icons = require("util.icons")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      opts.source_selector = {
        winbar = true,
        separator_active = "",
      }
      opts.popup_border_style = "rounded"
      opts.enable_git_status = true
      opts.git_status_async = true
      opts.filesystem.filtered_items = {
        visible = true,
        hise_dotfiles = false,
        hide_gitignored = false,
        never_show = { ".DS_Store", "thumbs.db" },
      }
      opts.default_component_configs = {
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
      }
    end,
    keys = {
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "[git] explorer",
      },
    },
  },
}
