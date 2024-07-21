return {
  "andymass/vim-matchup",
  dependencies = "nvim-treesitter/nvim-treesitter",
  init = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    vim.g.matchup_matchparen_deferred = 1 -- improves performance
  end,
}
