return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
      timeout = 3000,
      render = "wrapped-compact",
      fps = 75,
      on_open = function(win)
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_set_config(win, { border = border })
        end
      end,
      background_colour = "#000000", --the colour that will be used for 100% transparency.
    },
    keys = {
      { "<leader>un", false },
      {
        "<leader>ux",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss Notifications",
      },
    },
  },
}
