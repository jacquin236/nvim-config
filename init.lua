vim.g.vim_dir = vim.fn.expand("~/.config/nvim")
vim.g.projects_dir = vim.env.PROJECTS_DIR or vim.fn.expand("~/projects")

if vim.loader then vim.loader.enable() end
if vim.env.VSCODE then vim.g.vscode = true end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
