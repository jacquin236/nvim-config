-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

local o, opt, g = vim.o, vim.opt, vim.g

--Encoding
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Keymap leader
g.mapleader = " "
g.maplocalleader = "\\"

-- Timings
o.updatetime = 300
o.timeout = true
o.timeoutlen = 500
o.ttimeoutlen = 10

-- Windows split
o.splitkeep = "screen"
o.splitbelow = true
o.splitright = true

-- Display
o.breakindentopt = "sbr"
o.linebreak = true -- lines wrap at words rather than random characters
o.ruler = false
o.cmdheight = 0
opt.statuscolumn = [[%!v:lua.require'util.statusline'.statuscolumn()]]

-- Indentation
o.wrap = false
o.wrapmargin = 2
o.autoindent = true
o.smartindent = true
o.shiftwidth = 2
o.shiftround = true
o.expandtab = true

-- diff
opt.diffopt = opt.diffopt
  + {
    "vertical",
    "iwhite",
    "hiddenoff",
    "foldcolumn:0",
    "context:4",
    "algorithm:histogram",
    "indent-heuristic",
    "linematch:60",
  }

-- Search
o.ignorecase = true
o.incsearch = true
o.hlsearch = true
o.infercase = true
o.smartcase = true
o.scrolloff = 9
o.sidescroll = 1
o.sidescrolloff = 10

-- List chars
opt.listchars = {
  tab = "│ ",
  extends = "…",
  precedes = "░",
  trail = "…",
}
-- Fillchars
--[[ opt.fillchars = {
  eob = " ", -- suppress ~ at EndOfBuffer
  diff = "╱", -- alternatives = ⣿ ░ ─
  msgsep = " ", -- alternatives: ‾ ─
  fold = " ",
  foldopen = "▽", -- '▼'
  foldclose = "▷", -- '▶'
  foldsep = " ",
} ]]

opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

o.laststatus = 3

-- Backup and swap
o.backup = false
o.undofile = true
o.swapfile = false

-- Number
opt.number = true
opt.relativenumber = false
opt.numberwidth = 4
opt.ruler = false

-- Mouse
o.mouse = "a"
o.mousefocus = true
o.mousemoveevent = true
opt.mousescroll = { "ver:1", "hor:6" }

opt.path:append({ "**" })
opt.wildignore:append({ "*/node_module/*" })
opt.whichwrap:append("<>[]hl")

if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
end
