--- List of themes includes:
---
--- "aurora",
--- "bamboo",
--- "catppuccin", "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha",
--- "cyberdream",
--- "dracula",
--- "gruvbox",
--- "kanagawa",
--- "moonfly",
--- "nightfly",
--- "nightfox", "duskfox", "carbonfox", "dawnfox", "dayfox", "nordfox", "terafox",
--- "solarized-osaka", "solarized-osaka-day", "solarized-osaka-moon", "solarized-osaka-night", "solarized-osake-storm"
--- "tokyonight", "tokyonight-moon", "tokyonight-night", "tokyonight-day", "tokyonight-storm",
---
--- "onedark" : different styles - "dark", "darker", "cool", "deep", "warm", "warmer" and "light"
---
--- "material" :
--- different styles can be set as `vim.g.material_style = 'deep ocean'`. Styles available:
--- "darker", "lighter", "oceanic", "palenight", and "deep ocean"

--- Colors and settings can be overridden in plugins/themes directory

return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight" },
  },
}
