return {
  "zeioth/garbage-day.nvim",
  event = "VeryLazy",
  opts = {
    notifications = true,
    wakeup_delay = 200,
    grace_period = 60 * 15,
  },
  keys = {
    {
      "<leader>clg",
      function()
        return require("garbage-day.utils").stop_lsp()
      end,
      desc = "[garbage-day] Stop All Lsp Clients",
    },
    {
      "<leader>clG",
      function()
        return require("garbage-day.utils").start_lsp()
      end,
      desc = "[garbage-day] Start Lsp Clients (Current Buffer)",
    },
  },
}
