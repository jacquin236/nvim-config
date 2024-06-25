return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  name = "vscode",
  config = function()
    require("vscode").setup({
      transparent = vim.g.transparent_enabled,
    })
  end,
}
