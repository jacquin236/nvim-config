local border = require("util.icons").border.rounded
local divider = require("util.icons").dividers.ThinLineMiddle

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>i", group = "info", icon = " " },
        { "<leader>iL", group = "lint", icon = " " },
        { "<leader>ir", group = "root", icon = "󰆥 " },
        { "<leader>ic", group = "conform", icon = "󰊄 " },
        { "<leader>iC", group = "cmp (status)", icon = "󱖫 " },
        { "<leader>l", group = "lazy", icon = "󰒲 " },
        { "<leader>u", group = "ui", icon = " " },
        { "<leader>x", group = "diagnostic/quickfix", icon = "󰁨 " },
        { "<leader>b", group = "buffer", icon = " " },
        { "<leader>f", group = "find/file", icon = "󰈞" },
        { "<leader>s", group = "search/replace", icon = " " },
      },
      ---@type wk.Win
      win = {
        height = { min = 4, max = 20 },
        padding = { 2, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        wo = { winblend = 0 },
        border = border,
        row = -3,
      },
      preset = "modern",
      sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase", "desc" },
      layout = {
        width = { min = 20, max = 40 },
        align = "center",
        spacing = 4,
      },
      icons = {
        separator = divider .. " ",
        group = " •",
        colors = false,
        rules = {
          { pattern = "octo", icon = " " },
          { pattern = "hover", icon = "" },
          { pattern = "inspect", icon = " " },
          { pattern = "replace", icon = "󰛔" },
          { pattern = "history", icon = " " },
          { pattern = "help", icon = "󰋖" },
          { pattern = "grep", icon = " " },
          { pattern = "select", icon = " " },
          { pattern = "lsp", icon = " " },
          { pattern = "breakpoints", icon = " " },
        },
      },
    },
  },
}
