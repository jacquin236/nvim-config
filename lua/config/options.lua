
-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

local o, opt, g = vim.o, vim.opt, vim.g

-- Root dir detection
g.root_spec = { "lsp", { ".git", "lua", "Makefile", "go.mod", "cargo.toml", "src" }, "cwd" }
 
o.wrapmargin = 2
o.autoindent = true
o.smartindent = true
o.shiftwidth = 2
o.shiftround = true
o.expandtab = true

-- Backspace
opt.backspace = { "start", "eol", "indent" }
opt.breakindent = true

-- diff
opt.diffopt = {
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
o.scrolloff = 10
o.sidescroll = 1
o.sidescrolloff = 10

-- List chars
opt.listchars = {
  tab = "│ ",
  extends = "…",
  precedes = "░",
  trail = "…",
}

opt.fillchars = {
  eob = " ", -- suppress ~ at EndOfBuffer
  diff = "╱", -- alternatives = ⣿ ░ ─
  msgsep = " ", -- alternatives: ‾ ─
  fold = " ",
  foldopen = "▼",
  foldclose = "▶",
  foldsep = " ",
  -- Required neovim >= 7.0
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

-- Disable cmdline stuff
o.showcmd = false
o.laststatus = 3
o.cmdheight = 0

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

g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

if vim.g.neovide then
  vim.o.guifont = "Fira Code,Symbols Nerd Font Mono:h34"
  vim.g.neovide_scale_factor = 0.3
  vim.g.neovide_window_blurred = true
  vim.g.neovide_transparency = 0.7
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_smooth_blink = true
end
