return {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "dmitmel/cmp-cmdline-history",
  "hrsh7th/cmp-emoji",
  "saadparwaiz1/cmp_luasnip",
  "lukas-reineke/cmp-rg",
  "rafamadriz/friendly-snippets",
  "SergioRibera/cmp-dotenv",
  {
    "garymjr/nvim-snippets",
    opts = { friendly_snippets = true }
  },
  {
    "petertriho/cmp-git",
    opts = {
      filetypes = { "gitcommit", "NeogitCommitMessage" },
    },
  },
  {
    "f3fora/cmp-spell",
    ft = { "gitcommit", "NeogitCommitMessage", "markdown", "norg", "org" },
  },
  {
    "David-Kunz/cmp-npm",
    dependencies = "nvim-lua/plenary.nvim",
    ft = "json",
    opts = {},
  },
  "amarakon/nvim-cmp-fonts",
  "chrisgrieser/cmp-nerdfont",
  "lukas-reineke/cmp-under-comparator",
}
