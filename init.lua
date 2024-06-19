if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

if vim.fn.has("win32") == 1 then
  return
else
  vim.env.DYLD_LIBRARY_PATH = "$HOMEBREW_PREFIX/lib/"
end

vim.g.projects_dir = vim.env.PROJECTS_DIR or vim.fn.expand("~/projects")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
