return {
  {
    "xiyaowong/nvim-transparent",
    cmd = { "TransparentEnable", "TransparentToggle", "TransparentDisable" },
    keys = {
      { "<localleader>t", "<cmd>TransparentToggle<cr>", desc = "Transparent: Toggle" },
      { "<localleader>to", "<cmd>TransparentEnable<cr>", desc = "Transparent: Enable" },
      { "<localleader>tf", "<cmd>TransparentDisable<cr>", desc = "Transparent: Disable" },
    },
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat",
          "Pmenu",
          "NeoTreeNormal",
          "NeoTreeNormalNC",
        },
      })
    end,
  },
  {
    "folke/styler.nvim",
    config = function()
      require("styler").setup({
        themes = {
          markdown = { colorscheme = "catppuccin-mocha", background = "dark" },
          help = { colorscheme = "catppuccin-mocha", background = "dark" },
          lua = { colorscheme = "cyberdream" },
          rust = { colorscheme = "tokyonight" },
          go = { colorscheme = "tokyonight" },
          json = { colorscheme = "aurora" },
          typescript = { colorscheme = "dustfox" },
        },
      })
    end,
  },
}
