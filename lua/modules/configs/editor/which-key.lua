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
        { "<leader>w", group = "windows", icon = " " },
        { "<leader>c", group = "code", icon = " " },
        { "<leader>b", group = "buffer" },
        { "<leader>g", group = "git", icon = "󰊢 " },
        { "<leader>q", group = "quit/session", icon = " " },
        { "<leader>f", group = "file/find", icon = "󰈞" },
        { "<leader><tab>", group = "tabs" },
      },
      ---@type wk.Win
      win = {
        height = { min = 4, max = 20 },
        padding = { 2, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        border = border,
      },
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
          { plugin = "octo.nvim", icon = " " },
          { pattern = "hover", icon = "" },
          { pattern = "inspect", icon = " " },
          { pattern = "replace", icon = "󰛔" },
          { pattern = "history", icon = " " },
          { pattern = "help", icon = "󰋖" },
          { pattern = "grep", icon = " " },
          { pattern = "select", icon = " " },
          { pattern = "lsp", icon = " " },
          { pattern = "breakpoints", icon = " " },
          { pattern = "mark", icon = " " },
          { pattern = "up", icon = " " },
          { pattern = "down", icon = " " },
          { pattern = "keyword", icon = "󰌆 " },
          { pattern = "keymap", icon = "  " },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Keymaps (local buffer)",
      },
    },
  },
}
