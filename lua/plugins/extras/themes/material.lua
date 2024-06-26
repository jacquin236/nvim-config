return {
  "marko-cerovac/material.nvim",
  lazy = false,
  config = function()
    require("material").setup({
      lualine_style = "default",
      high_visibility = { darker = true, lighter = true },
      plugins = {
        "dap",
        "dashboard",
        "fidget",
        "gitsigns",
        "illuminate",
        "indent-blankline",
        "mini",
        "neogit",
        "neotest",
        "neo-tree",
        "noice",
        "nvim-cmp",
        "nvim-web-devicons",
        "rainbow-delimiters",
        "telescope",
        "trouble",
        "which-key",
        "nvim-notify",
      },
      disable = {
        background = vim.g.transparent_enabled,
      },
    })
    vim.g.material_style = "deep ocean"
  end,
}
