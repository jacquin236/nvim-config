if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

vim.env.DYLD_LIBRARY_PATH = "$HOMEBREW_PREFIX/lib/"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
