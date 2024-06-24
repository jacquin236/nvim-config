return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = { enabled = true, suggestions = 15 } },
      window = {
        border = require("util.ui").border,
        position = "bottom",
        margin = { 2, 2, 2, 2 },
        padding = { 1, 0, 1, 0 },
        winblend = 0,
      },
      layout = {
        spacing = 1,
        align = "center",
      },
      defaults = {
        ["<leader>ci"] = { name = "  Info" },
        ["<leader><tab>"] = { name = "󰓩  Tabs" },
        ["<leader>b"] = { name = "󰖯  uffer" },
        ["<leader>c"] = { name = "  Code" },
        ["<leader>f"] = { name = "  File/Find" },
        ["<leader>g"] = { name = " Git" },
        ["<leader>l"] = { name = "󰒲  Lazy" },
        ["<leader>q"] = { name = "󰗼  Quit/Session" },
        ["<leader>s"] = { name = "  Search" },
        ["<leader>u"] = { name = "  Ui" },
        ["<leader>w"] = { name = "󱂬 Windows" },
        ["<leader>x"] = { name = "󰁨 Diagnostics/Quickfix" },
      },
    },
  },
}
