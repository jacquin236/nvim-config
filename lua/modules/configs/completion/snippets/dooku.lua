return {
  {
    "Zeioth/dooku.nvim",
    cmd = { "DookuGenerate", "DookuOpen", "DookuAutoSetup" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ag", "<cmd>DookuGenerate<cr>", desc = "[dooku] generate HTML docs" },
      { "<leader>ao", "<cmd>DookuOpen<cr>", desc = "[dooku] open HTML docs" },
    },
  },
}
