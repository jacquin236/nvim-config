local palette = require("catppuccin.palettes").get_palette("mocha") -- Import your favorite catppuccin colors

return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      transparent_background = vim.g.transparent_enabled,
      flavour = "mocha",
      styles = {
        comments = { "italic" },
      },
      background = {
        light = "latte",
        dark = "mocha",
      },
      term_colors = true,
      custom_highlights = function()
        return {
          TelescopeMatching = { fg = palette.blue },
          TelescopeSelection = { fg = palette.text, bg = palette.surface0, bold = true },
          TelescopePromptPrefix = { bg = palette.surface0 },
          TelescopePromptNormal = { bg = palette.surface0 },
          TelescopeResultsNormal = { bg = palette.mantle },
          TelescopePreviewNormal = { bg = palette.mantle },
          TelescopePromptTitle = { bg = palette.mauve, fg = palette.mantle },
          TelescopeResultsTitle = { fg = palette.mantle },
          TelescopePreviewTitle = { bg = palette.green, fg = palette.mantle },
        }
      end,
      integrations = {
        cmp = true,
        dap = true,
        dap_ui = true,
        dashboard = true,
        diffview = true,
        dropbar = { enabled = true, color_mode = true },
        flash = true,
        headlines = true,
        gitsigns = true,
        harpoon = false,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        lsp_trouble = true,
        navic = { enabled = false, custom_bg = "lualine" },
        neotest = true,
        neogit = true,
        neotree = true,
        notify = true,
        noice = true,
        overseer = false,
        octo = false,
        rainbow_delimiters = true,
        semantic_tokens = true,
        telescope = {
          enabled = true,
        },
        symbols_outline = false,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("tiny-devicons-auto-colors").setup({
        colors = palette,
        factors = {
          lightness = 0.8,
          chroma = 1,
          hue = 1,
        },
      })
    end,
  },
}
