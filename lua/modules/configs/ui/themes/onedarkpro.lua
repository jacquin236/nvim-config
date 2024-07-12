return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  name = "onedarkpro",
  config = function()
    require("onedarkpro").setup({
      options = {
        cursorline = true,
        transparency = vim.g.transparent_enabled,
      },
    })
  end,
}
