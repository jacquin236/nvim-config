return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", opts = { enable = true, multiline_threshold = 3, mode = "cursor" } },
      { "andymass/vim-matchup" },
      { "HiPhish/rainbow-delimiters.nvim" },
      { "chrisgrieser/nvim-puppeteer" },
      { "RRethy/nvim-treesitter-endwise" },
    },
    opts = function(_, opts)
      opts.matchup = { enable = true, include_match_words = true }
      opts.textobjects = { enable = true }
      opts.rainbow = { enable = true, query = "rainbow-delimiters" }
      opts.endwise = { enable = true }
    end,
  },
}
