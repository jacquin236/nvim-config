return {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  lazy = false,
  config = function()
    vim.g.nightflyCursorColor = true
    vim.g.nightflyUnderlineMatchParen = true
    vim.g.nightflyVirtualTextColor = true
    vim.g.nightflyWinSeparator = 2
    vim.g.nightflyTransparent = true
  end,
}
