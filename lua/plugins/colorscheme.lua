return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = false,
      --styles = {
      --sidebars = "transparent",
      --floats = "transparent",
      --},
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        dim_active = false,
        styles = {
          comments = "italic",
          keywords = "italic",
        },
        modules = {
          "alpha",
          "cmp",
          "dashboard",
          "dap_ui",
          "diagnostic",
          "gitsigns",
          "illuminate",
          "indent_blankline",
          "lazy",
          "mini",
          "native_lsp",
          "navic",
          "neogit",
          "neotree",
          "notify",
          "nvimtree",
          "telescope",
          "treesitter",
          "whichkey",
        },
      },
    },
  },
  {
    "dracula/vim",
    name = "dracula",
    lazy = true,
  },
  {
    "LunarVim/lunar.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      term_colors = true,
      integrations = {
        alpha = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        dashboard = true,
        diffview = true,
        dropbar = true,
        flash = true,
        gitsigns = true,
        harpoon = true,
        leap = true,
        markdown = true,
        mason = true,
        mini = { enabled = true },
        neotree = true,
        neogit = true,
        noice = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
            ok = { "undercurl" },
          },
        },
        navic = true,
        notify = true,
        semantic_tokens = true,
        nvimtree = true,
        treesitter_context = true,
        treesitter = true,
        window_picker = true,
        octo = true,
        rainbow_delimiters = true,
        telescope = { enabled = true },
        lsp_trouble = true,
        illuminate = { enabled = true, lsp = true },
        which_key = true,
      },
    },
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.nightflyCursorColor = true
      vim.g.nightflyUnderlineMatchParen = true
      vim.g.nightflyVirtualTextColor = true
      vim.g.nightflyWinSeparator = 2
    end,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.moonflyCursorColor = true
      vim.g.moonflyUnderlineMatchParen = true
      vim.g.moonflyVirtualTextColor = true
      vim.g.moonflyWinSeparator = 2
    end,
  },
  {
    "xiyaowong/nvim-transparent",
    cmd = { "TransparentEnable", "TransparentToggle", "TransparentDisable" },
    keys = {
      { "<localleader>t", "<cmd>TransparentToggle<cr>", desc = "Toggle Transparent" },
      { "<localleader>to", "<cmd>TransparentEnable<cr>", desc = "Enable Transparent" },
      { "<localleader>tf", "<cmd>TransparentDisable<cr>", desc = "Disable Transparent" },
    },
    config = function()
      require("transparent").setup({
        extra_groups = { "NormalFloat", "Pmenu" },
      })
    end,
  },
  -- Bootstrap colorscheme here
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "duskfox" },
  },
}
