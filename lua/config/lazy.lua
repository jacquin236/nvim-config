vim.g.projects_dir = vim.env.PROJECTS_DIR or vim.fn.expand("~/projects")

---------------------------------------------------- lazy.nvim -------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

--- Specify local sources for customize lazy ui
local icons = require("util.icons")
local border = icons.border.rounded

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    {
      import = "modules.plugins",
      cond = function()
        return not vim.g.vscode
      end,
    },
  },
  defaults = { lazy = true },
  diff = { cmd = "terminal_git" },
  install = { colorscheme = { "tokyonight", "catppuccin" } },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = true, notify = false },
  performance = {
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = { vim.fn.stdpath("data") .. "/site" },
      disabled_plugins = {
        "2html_plugin",
        "bugreport",
        "compiler",
        "ftplugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "matchparen",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "rplugin",
        "rrhelper",
        "syntax",
        "synmenu",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = border,
    size = { width = 0.9, height = 0.8 },
    icons = {
      not_loaded = icons.ui.Ghost .. " ",
      loaded = icons.ui.CheckBold .. " ",
      source = icons.kind.StaticMethod .. " ",
      start = icons.ui.Play .. " ",
      favorite = icons.ui.Heart .. " ",
      event = icons.kind.Event .. " ",
      task = icons.ui.CheckCircle .. " ",
      init = icons.ui.Compass .. " ",
    },
    backdrop = 80,
  },
  dev = {
    path = vim.g.projects_dir .. "/nvim-projects",
    patterns = {},
    fallback = true,
  },
})
