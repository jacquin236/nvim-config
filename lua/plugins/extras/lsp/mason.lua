return {
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm",  false },
      { "<leader>cim", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  { import = "plugins.extras.tools.mason-lock" },
}
