if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

if vim.fn.has("win32") == 0 then
  vim.env.DYLD_LIBRARY_PATH = "$HOMEBREW_PREFIX/lib/"
else
  return
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
