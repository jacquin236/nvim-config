return {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  lazy = false,
  config = function()
    vim.g.nightflyCursorColor = true
    vim.g.nightflyTransparent = vim.g.transparent_enabled
    vim.g.nightflyVirtualTextColor = true
    vim.g.nightflyWinSeparator = 2
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
