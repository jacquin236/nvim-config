return {
  {
    "yorickpeterse/nvim-pqf",
    event = "VeryLazy",
    config = function()
      require("pqf").setup()
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = { "qf" },
    config = function()
      vim.api.nvim_set_hl(0, "BqfReviewBorder", { link = "Comment" })
    end,
  },
}
