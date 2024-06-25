return {
  "Everblush/nvim",
  name = "everblush",
  lazy = false,
  config = function()
    require("everblush").setup({
      transparent_background = vim.g.transparent_enabled,
    })
  end,
}
