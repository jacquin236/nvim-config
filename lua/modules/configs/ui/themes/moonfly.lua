return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  config = function()
    vim.g.moonflyCursorColor = true
    vim.g.moonflyTransparent = vim.g.transparent_enabled
    vim.g.moonflyVirtualTextColor = true
    vim.g.moonflyWinSeparator = 2
    vim.opt.fillchars = {
      horiz = "━",
      horizup = "┻",
      horizdown = "┳",
      vert = "┃",
      vertleft = "┫",
      vertright = "┣",
      verthoriz = "╋",
    }
  end,
}
