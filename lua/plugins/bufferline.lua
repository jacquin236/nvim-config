return {
  {
    "akinsho/bufferline.nvim",
    event = "UIEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        close_command = function(n)
          LazyVim.ui.bufremove(n)
        end,
        right_mouse_command = "vert sbuffer %d",
        left_mouse_command = "buffer %d",
        diagnostics = false,
        always_show_bufferline = true,
        auto_toggle_bufferline = true,
        show_duplicate_prefix = true,
        duplicates_across_groups = true,
        move_wraps_at_ends = false,
        groups = {
          items = {
            require("bufferline").groups.builtin.pinned:with({ icon = "" }),
            require("bufferline").groups.builtin.ungrouped,
          },
          options = { toggle_hidden_on_enter = true },
        },
        themeable = true,
        numbers = "none",
        separator_style = { "▌", "▌" },
        indicator = { style = "slope" },
        hover = {
          enabled = true,
          delay = 100,
          reveal = { "close" },
        },
        sort_by = "id",
        debug = { logging = false },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        enforce_regular_tabs = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = " EXPLORER",
            highlight = "PanelHeading",
            text_align = "left",
            separator = true,
          },
          {
            text = "UNDOTREE",
            filetype = "undotree",
            highlight = "PanelHeading",
            separator = true,
          },
          {
            text = " DIFF VIEW",
            filetype = "DiffviewFiles",
            highlight = "PanelHeading",
            separator = true,
          },
          {
            filetype = "lazy",
            text = "💭 LAZY",
            highlight = "PanelHeading",
            separator = true,
          },
        },
        get_element_icon = function(element)
          local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
