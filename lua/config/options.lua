-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local g = vim.g
local o = vim.o
local opt = vim.opt

-- autoformat
g.autoformat = true
o.confirm = true -- prompt before save

-- Font
g.gui_font_default_size = 12
g.gui_font_size = g.gui_font_default_size
g.gui_font = "JetBrainsMono Nerd Font"

-- Support true colors
opt.termguicolors = true

-- Line and backspace and indentation
opt.backspace = { "start", "eol", "indent" }
o.linebreak = true -- lines wrap at words rather than random characters
o.showbreak = "↪ " -- character show in front of wrapped lines, options include -> '…', '↳ ', '→','↪ '
o.wrap = false
o.wrapmargin = 2
o.textwidth = 80
o.autoindent = true
o.smartindent = true
o.shiftround = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2

-- File encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Buffers
o.switchbuf = "useopen,uselast"
opt.fillchars = {
  eob = " ",
  diff = "░",
  msgsep = " ", -- alternatives: ‾ ─
  fold = " ",
  foldopen = "▼",
  foldclose = "▶",
  foldsep = " ",
}
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
opt.foldtext = ""

-- statuscolumn
opt.statuscolumn = [[%!v:lua.require'util.statuscolumn'.statuscolumn()]]
vim.g.lazyvim_statuscolumn = {
  folds_open = true, -- show fold sign when fold is open
  folds_githl = true, -- highlight fold sign with git sign color
}

-- Grepprg
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = 'rg --glob "!.git" --no-heading --vimgrep --follow $*'

-- List
o.list = true
opt.listchars = {
  eol = " ",
  tab = "  ",
  extends = "…", -- Alternatives: … » ›
  precedes = "«",
  trail = "•",
}

-- Diff
opt.diffopt:append({
  "vertical",
  "iwhite",
  "hiddenoff",
  "foldcolumn:0",
  "context:4",
  "algorithm:histogram",
  "indent-heuristic",
  "linematch:60",
})

-- Mouse and cursor
opt.mouse = "a"
opt.mousefocus = true
opt.mousemoveevent = true
opt.mousescroll = "ver:1,hor:6"
opt.smoothscroll = true
-- enables mode shapes, "Cursor" highlight, and blinking
opt.guicursor = {
  "n-v-c-sm:block-Cursor",
  "i-ci-ve:ver25-iCursor",
  "r-cr-o:hor20-Cursor",
  "a:blinkon0",
}
opt.cursorline = true
opt.cursorlineopt = { "both" }

-- Search and match
o.wrapscan = true -- Searches wrap around the end of the file
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.scrolloff = 10
o.sidescrolloff = 10
o.sidescroll = 1
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

-- number
opt.number = true
opt.numberwidth = 3
opt.relativenumber = true
opt.ruler = false

-- Backup, undo and swap file options
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.undolevels = 10000
opt.swapfile = false

-- Timings
opt.updatetime = 150
o.timeout = true
o.timeoutlen = 200

-- Popup
opt.pumblend = 0
opt.pumheight = 15

opt.path:append({ "**" }) -- Finding files - Search down into subfolders

-- Wild and file globbing in cmd mode
opt.wildignore:append({ "*/node_module/*" })
opt.wildmode = "longest:full,full" -- Command-line completion mode
o.wildcharm = ("\t"):byte()
o.wildignorecase = true -- Ignore case when completing file names and directories
o.cmdheight = 0
o.showmode = false

-- Session
opt.sessionoptions =
  { "buffers", "curdir", "tabpages", "terminal", "winsize", "winpos", "help", "globals", "skiprtp", "folds" }

-- title
local icons = require("util.icons")
o.title = true
o.titlelen = 70
o.titlestring = icons.ui.Neovim .. " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

-- disable some builtin providers
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

-- Python env setup if exists
local isempty = function(s)
  return s == nil or s == ""
end
local use_if_defined = function(val, fallback)
  return val ~= nil and val or fallback
end

local conda_prefix = os.getenv("CONDA_PREFIX")
if not isempty(conda_prefix) then
  vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_prefix .. "/bin/python")
  vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_prefix .. "/bin/python")
else
  vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
  vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- clipboard settings for WSL
local is_wsl = vim.fn.has("wsl") == 1
if is_wsl then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r", ""))',
      ["*"] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
else
  vim.g.clipboard = false
  vim.opt.clipboard = "unnamedplus"
end

-- terminal settings for windows
if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
end
