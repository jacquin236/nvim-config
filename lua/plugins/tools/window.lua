return {
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    keys = {
      {
        "<leader>wp",
        function()
          local winnr = require("window-picker").pick_window()
          if winnr ~= nil then
            vim.api.nvim_set_current_win(winnr)
          end
        end,
        desc = "Pick window",
      },
    },
    opts = {
      show_prompt = false,
      hint = "floating-big-letter",
      filter_rules = {
        bo = { filetype = { "incline", "noice" } },
      },
    },
    config = function(_, opts)
      local picker = require("window-picker")
      picker.setup(opts)
      picker.pick_window = function()
        return picker.select({ hl = "WindowPicker", prompt = "Pick Window: " }, function(winid)
          return winid or nil
        end)
      end
    end,
  },
  {
    "sindrets/winshift.nvim",
    opts = {},
    keys = { { "<leader>ws", "<cmd>WinShift<cr>", desc = "Win Shift/Swap" } },
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
      require("smart-splits").setup({
        silent = true,
        hooks = {
          on_enter = function()
            vim.notify("Entering Resize Mode")
          end,
          on_leave = function()
            vim.notify("Existing Resize Mode")
          end,
        },
      })
    end,
    keys = {
      {
        "<A-h>",
        function()
          return require("smart-splits").resize_left
        end,
        mode = { "n", "t" },
        desc = "Window Resize Left",
      },
      {
        "<A-j>",
        function()
          return require("smart-splits").resize_down
        end,
        mode = { "n", "t" },
        desc = "Window Resize Down",
      },
      {
        "<A-k>",
        function()
          return require("smart-splits").resize_up
        end,
        mode = { "n", "t" },
        desc = "Window Resize Up",
      },
      {
        "<A-l>",
        function()
          return require("smart-splits").resize_right
        end,
        mode = { "n", "t" },
        desc = "Window Resize Right",
      },
      {
        "<C-h>",
        function()
          return require("smart-splits").move_cursor_left
        end,
        mode = { "n", "t" },
        desc = "Window Move Cursor Left",
      },
      {
        "<C-j>",
        function()
          return require("smart-splits").move_cursor_down
        end,
        mode = { "n", "t" },
        desc = "Window Move Cursor Down",
      },
      {
        "<C-k>",
        function()
          return require("smart-splits").move_cursor_up
        end,
        mode = { "n", "t" },
        desc = "Window Move Cursor Up",
      },
      {
        "<C-l>",
        function()
          return require("smart-splits").move_cursor_right
        end,
        mode = { "n", "t" },
        desc = "Window Move Cursor Right",
      },
      {
        "<C-\\>",
        function()
          return require("smart-splits").move_cursor_previous
        end,
        mode = { "n", "t" },
        desc = "Window Move Cursor Previous",
      },
      {
        "<localleader><localleader>h",
        function()
          return require("smart-splits").swap_buf_left
        end,
        mode = "n",
        desc = "Swap Buffers Left",
      },
      {
        "<localleader><localleader>j",
        function()
          return require("smart-splits").swap_buf_down
        end,
        mode = "n",
        desc = "Swap Buffers Down",
      },
      {
        "<localleader><localleader>k",
        function()
          return require("smart-splits").swap_buf_up
        end,
        mode = "n",
        desc = "Swap Buffers Up",
      },
      {
        "<localleader><localleader>l",
        function()
          return require("smart-splits").swap_buf_right
        end,
        mode = "n",
        desc = "Swap Buffers Right",
      },
      {
        "<leader>wr",
        "<cmd>SmartResizeMode<cr>",
        mode = "n",
        desc = "Window Resize Mode",
      },
    },
  },
}
