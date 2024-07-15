return {
  {
    "otavioschwanck/arrow.nvim",
    event = "VeryLazy",
    opts = {
      show_icons = true,
      save_path = function()
        return vim.fn.stdpath("cache") .. "/arrow"
      end,
      window = {
        width = "auto",
        height = "auto",
        row = "auto",
        col = "auto",
        border = require("util.icons").border.rounded,
      },
      per_buffer_config = {
        lines = 6,
        sort_automatically = true,
      },
    },
    keys = {
      {
        "<leader>m",
        function()
          require("arrow.ui").openMenu()
        end,
        desc = "Marks",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, require("arrow.statusline").text_for_statusline_with_icons())
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      -- stylua: ignore
      local arrow = {
        action = function() require("arrow.ui").openMenu() end,
        desc = " Marks",
        icon = "󰛢 ",
        key = "m",
      }

      arrow.desc = arrow.desc .. string.rep(" ", 43 - #arrow.desc)
      arrow.key_format = "  %s"

      table.insert(opts.config.center, 5, arrow)
    end,
  },
}
