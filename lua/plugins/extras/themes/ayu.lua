return {
  "Shatur/neovim-ayu",
  lazy = false,
  config = function()
    require("ayu").setup({
      mirage = true,
      terminal = true,
    })
  end,
}
