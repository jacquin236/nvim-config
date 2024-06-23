return {
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {
      progress = {
        suppress_on_insert = false,
        ignore_done_already = false,
        display = {
          render_limit = 5,
          done_ttl = 2,
          done_icon = "✔",
          progress_icon = { pattern = "moon" },
        },
      },
      notification = {
        override_vim_notify = false,
        window = {
          winblend = 0,
          zindex = 100,
          border = "none",
          x_padding = 1,
          y_padding = 1,
          align = "bottom",
          relative = "editor",
        },
      },
    },
    config = function(_, opts)
      require("fidget").setup(opts)
    end,
    keys = {
      { "<localleader>f", "<cmd>Fidget<cr>", mode = "n", desc = "Fidget: Toggle" },
      { "<localleader>fc", "<cmd>Fidget clear<cr>", mode = "n", desc = "Fidget: Clear Active Notifications" },
      { "<localleader>fC", "<cmd>Fidget clear_history", mode = "n", desc = "Fidget: Clear Notifications History" },
      { "<localleader>fh", "<cmd>Fidget history<cr>", mode = "n", desc = "Fidget: Show Notifications History" },
      {
        "<localleader>fl",
        "<cmd>Fidget lsp_suppress<cr>",
        mode = "n",
        desc = "Fidget: Suppress LSP Progress Notifications",
      },
      { "<localleader>fs", "<cmd>Fidget suppress<cr>", mode = "n", desc = "Fidget: Suppress Notification Window" },
    },
  },
}
