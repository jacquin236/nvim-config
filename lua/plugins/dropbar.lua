local lspkind = require("lspkind")

return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    keys = {
      {
        "<leader>wp",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Winbar: Pick",
      },
    },
    opts = {
      update_interval = 100,
      icons = {
        ui = {
          bar = { separator = " » " },
        },
        kinds = { symbols = vim.tbl_map(function(value)
          return value .. " "
        end, lspkind.symbol_map) },
      },
      menu = {
        win_configs = {
          col = function(menu)
            return menu.prev_menu and menu.prev_menu._win_configs.width + 1 or 0
          end,
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
        scrollbar = { enable = false },
      },
    },
    config = function(_, opts)
      require("dropbar").setup(opts)
    end,
  },
}
