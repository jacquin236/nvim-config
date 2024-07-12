-- vim.loader = false
if vim.loader then
  vim.loader.enable()
end

-- vscode -- do nothing
if vim.env.VSCODE then
  vim.g.vscode = true
end

--- Map leader before setup lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[colorscheme catppuccin]])
