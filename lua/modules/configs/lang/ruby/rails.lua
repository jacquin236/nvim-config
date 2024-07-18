return {
  {
    "tpope/vim-rails",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "tpope/vim-abolish",
      "tpope/vim-bundler",
      "tpope/vim-endwise",
      "tpope/vim-dispatch",
    },
    ft = { "ruby" },
    opts = {},
  },
}
