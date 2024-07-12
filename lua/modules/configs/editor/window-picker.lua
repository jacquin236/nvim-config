local colors = require "util.colors"

return {
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    keys = {
      {
        "<leader>we",
        function()
          local winnr = require("window-picker").pick_window()
          if winnr ~= nil then
            vim.api.nvim_set_current_win(winnr)
          end
        end,
        desc = "Window Pick[e]r",
      },
    },
    opts = {
      show_prompt = false,
      hint = "floating-big-letter",
      filter_rules = {
        bo = {
          filetype = { "incline", "noice", "neo-tree", "notify", "neo-tree-popup" },
          buftype = { "terminal", "quickfix" },
        },
        autoselect_one = true,
        include_current_win = true,
      },
      picker_config = {
        statusline_winbar_picker = { use_winbar = "smart" },
        floating_big_letter = { font = "ansi-shadow" },
      },

      highlights = {
        enabled = true,
        winbar = {
          focused = {
            fg = colors.milk,
            bg = colors.anise,
            bold = true,
          },
          unfocused = {
            fg = colors.dust,
            bg = colors.anise_dark,
            italic = true,
            bold = false,
          },
        },
      },
    },
    config = function(_, opts)
      require("window-picker").setup(opts)
    end,
  },
}
