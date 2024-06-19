local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
  checker = {
    enabled = true,
    notify = false,
    frequency = 3600,
  },
  ui = {
    border = "rounded",
  },
  change_detection = { enabled = true, notify = false },
  performance = {
    rtp = {
      paths = { vim.fn.stdpath("data") .. "/site" },
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  dev = {
    path = vim.g.projects_dir .. '/nvim-projects',
    fallback = true,
  },
})
