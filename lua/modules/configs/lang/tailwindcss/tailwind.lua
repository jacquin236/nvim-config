return {
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<leader>cT", "<cmd>TWValues<cr>", desc = "Tailwind CSS values" },
    },
    opts = {},
  },
}
