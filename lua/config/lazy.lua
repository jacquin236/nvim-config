vim.g.projects_dir = vim.env.PROJECTS_DIR or vim.fn.expand("~/projects")

------------------------------------------ LazyVim Setup -------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        news = { lazyvim = true, neovim = true },
      },
    },
    { import = "plugins" },
  },
  defaults = { lazy = true, version = false },
  install = {
    missing = true,
    colorscheme = { "tokyonight", "catppuccin" },
  },
  checker = { enabled = true, concurrency = 30, notify = false, frequency = 3600 },
  change_detection = { enabled = true, notify = true },
  diff = { cmd = "terminal_git" },
  ui = {
    wrap = true,
    size = { width = 0.9, height = 0.9 },
    border = require("util.ui").border,
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      ttl = 3600 * 24 * 2,
    },
    reset_packpath = true,
    rtp = {
      paths = { vim.fn.stdpath("data") .. "/site" },
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  dev = {
    path = vim.g.projects_dir .. "/nvim-projects",
    patterns = { "jacquin236" },
    fallback = true,
  },
  debug = false,
})
