return {
  {
    "aurum77/live-server.nvim",
    build = function()
      require("live_server.util").install()
    end,
    cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    opts = {
      browser_command = "firefox",
      quite = true,
      no_css_inject = false,
      install_path = vim.fn.stdpath("data") .. "/live-server/",
    },
    config = function(_, opts)
      require("live_server").setup(opts)
    end,
    keys = {
      { "<leader>Sl", "<cmd>LiveServer<cr>", desc = "[live-server] Toggle Live Server" },
    },
  },
}
