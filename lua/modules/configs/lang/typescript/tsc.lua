return {
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact" },
    cmd = { "TSC", "TSCOpen", "TSCClose", "TSStop" },
    keys = {
      { "<leader>ct", ft = { "typescript", "typescriptreact" }, "<cmd>TSC<cr>", desc = "Type Check" },
      { "<leader>xy", ft = { "typescript", "typescriptreact" }, "<cmd>TSCOpen<cr>", desc = "Type Check Quickfix" },
    },
    opts = {
      auto_start_watch_mode = false,
      use_trouble_qflist = true,
      flags = { watch = false },
    },
  },
}
