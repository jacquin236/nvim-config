local cmp_extended = require("modules.configs.coding.completion.util.cmp_extended")

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
      { "f3fora/cmp-spell", ft = { "gitcommit", "NeogitCommitMessage", "markdown", "norg", "org" } },
      "rafamadriz/friendly-snippets",
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
    },
    keys = {
      { "<leader>iC", "<cmd>CmpStatus<cr>", desc = "cmp (status)" },
    },
    config = cmp_extended,
  },
}
