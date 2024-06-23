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

-- solves the issue of missing luarocks when using homebrew to run NeoVim
vim.env.DYLD_LIBRARY_PATH = "$HOMEBREW_PREFIX/lib/"
-- Configuring Neovim to load user-installed Luarocks:
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "./luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "./luarocks/share/lua/5.1/?.lua"

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        news = { lazyvim = true, neovim = true },
      },
    },
    { import = "plugins.editor" },
    { import = "plugins.ui" },
    { import = "plugins.ui.telescope" },
    { import = "plugins.lsp" },
    { import = "plugins.themes" },
    { import = "plugins.tools" },
  },
  defaults = { lazy = true, version = false },
  install = {
    missing = true,
    colorscheme = {
      "aurora",
      "bamboo",
      "catppuccin",
      "cyberdream",
      "dracula",
      "gruvbox",
      "kanagawa",
      "material",
      "moonfly",
      "nightfly",
      "solarized-osaka",
      "tokyonight",
      "nightfox",
      "cyberdream",
      "onedark",
    },
  },
  checker = { enabled = true, concurrency = 30, notify = false, frequency = 3600 },
  change_detection = { enabled = true, notify = true },
  diff = { cmd = "terminal_git" },
  ui = {
    wrap = true,
    size = { width = 0.9, height = 0.9 },
    border = "rounded",
    custom_keys = {
      ["<localleader>l"] = function(plugin)
        require("lazy.util").float_term({ "lazygit", "log" }, {
          cwd = plugin.dir,
        })
      end,
      ["<localleader>t"] = function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      disable_events = { "UIEnter", "BufReadPre" },
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
