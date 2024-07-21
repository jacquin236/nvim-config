local cmp_extended = require("util.cmp_extended")

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-under-comparator",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "saadparwaiz1/cmp_luasnip",
      { "f3fora/cmp-spell", ft = { "gitcommit", "NeogitCommitMessage", "markdown", "norg", "org" } },
    },
    keys = {
      { "<leader>iC", "<cmd>CmpStatus<cr>", desc = "Cmp" },
    },
    config = cmp_extended,
  },
}
