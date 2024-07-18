return {
  {
    "barrett-ruth/live-server.nvim",
    cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
    build = "pnpm add -g live-server",
    opts = {},
    config = function(_, opts)
      require("live-server").setup(opts)
    end,
    keys = {
      { "<leader>Ls", "<cmd>LiveServerStart<cr>", desc = "[live-server] Start" },
      { "<leader>LS", "<cmd>LiveServerStop<cr>", desc = "[live-server] Stop" },
      { "<leader>Ll", "<cmd>LiveServerToggle<cr>", desc = "[live-server] Toggle" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>L", group = "live server", icon = "󰖟 " },
      },
    },
  },
}
