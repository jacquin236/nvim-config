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
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>ag", group = "[dooku] generate HTML docs", icon = "" },
        { "<leader>ao", group = "[dooku] open HTML docs", icon = "" },
      },
    },
  },
}
