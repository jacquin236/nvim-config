return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  config = function()
    vim.g.moonflyCursorColor = true
    vim.g.moonflyUnderlineMatchParen = true
    vim.g.moonflyVirtualTextColor = true
    vim.g.moonflyWinSeparator = 2
  end,
}
