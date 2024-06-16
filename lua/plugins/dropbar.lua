local ui = require("util.ui")
local icons = ui.icons
local border = ui.border
local lspkind = require("lspkind")

return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { link = "Delimiter" })
      vim.api.nvim_set_hl(0, "DropBarMenuNormalFloat", { link = "Pmenu" })
    end,
    opts = {
      general = {
        update_interval = 100,
        enable = function(buf, win)
          local b, w = vim.bo[buf], vim.wo[win]
          return vim.fn.win_gettype(win) == ""
            and w.winbar == ""
            and b.bt == ""
            and not w.diff
            and not vim.api.nvim_win_get_config(win).zindex
            and vim.api.nvim_buf_get_name(buf) ~= ""
            and (
              b.ft == "markdown"
              or (
                buf and vim.api.nvim_buf_is_valid(buf) and (pcall(vim.treesitter.get_parser, buf, b.ft)) and true
                or false
              )
            )
        end,
      },
      icons = {
        enable = true,
        use_devicons = true,
        ui = { bar = { separator = " " .. icons.ui.DoubleChevronRight .. " " } },
        kinds = {
          symbols = vim.tbl_map(function(value)
            return value .. " "
          end, lspkind.symbol_map),
        },
      },
      menu = {
        scrollbar = { enable = false },
        win_configs = {
          border = border,
          style = "minimal",
          col = function(menu)
            return menu.prev_menu and menu.prev_menu._win_configs.width + 1 or 0
          end,
        },
      },
    },
    keys = {
      {
        "<leader>wp",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Winbar: Pick",
      },
    },
  },
}
