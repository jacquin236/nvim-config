return {
  {
    "LazyVim/LazyVim",
    config = function(_, opts)
      opts = opts or {}
      -- disable the colorscheme
      opts.colorscheme = function() end
      require("lazyvim").setup(opts)
    end,
  },
  {
    "zaldih/themery.nvim",
    cmd = "Themery",
    config = function()
      require("themery").setup({
        themes = {
          "aurora",
          "ayu",
          "ayu-dark",
          "ayu-light",
          "ayu-mirage",
          "bamboo",
          "bamboo-light",
          "bamboo-multiplex",
          "bamboo-vulgaris",
          "catppuccin",
          "catppuccin-frappe",
          "catppuccin-latte",
          "catppuccin-macchiato",
          "catppuccin-mocha",
          "cyberdream",
          "doom-one",
          "dracula",
          "dracula-soft",
          "everblush",
          "fluoromachine",
          "gruvbox",
          "habamax",
          "horizon",
          "juliana",
          "kanagawa",
          "kanagawa-dragon",
          "kanagawa-lotus",
          "kanagawa-wave",
          "material",
          "material-darker",
          "material-deep-ocean",
          "material-lighter",
          "material-oceanic",
          "material-palenight",
          "moonfly",
          "nightfly",
          "nightfox",
          "carbonfox",
          "dawnfox",
          "dayfox",
          "duskfox",
          "nordfox",
          "onedark",
          "solarized-osaka",
          "solarized-osaka-day",
          "solarized-osaka-night",
          "solarized-osaka-moon",
          "solarized-osaka-storm",
          "sonokai",
          "sorbet",
          "tokyonight",
          "tokyonight-day",
          "tokyonight-moon",
          "tokyonight-night",
          "tokyonight-storm",
          "vscode",
        },
        themeConfigFile = "~/.config/nvim/lua/config/theme.lua",
        livePreview = true,
      })
    end,
    keys = {
      { "<leader>uy", "<cmd>Themery<cr>", desc = "Themery Toggle Themes" },
    },
  },
}
