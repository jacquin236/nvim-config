local border = require("util.icons").border.rounded
local divider = require("util.icons").dividers.ThinLineMiddle
local map_icons = require("util.keymap-icons")

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "Tabs" },
          { "<leader>b", group = "Buffer" },
          { "<leader>c", group = "Code" },
          { "<leader>f", group = "File/Find" },
          { "<leader>g", group = "Git" },
          { "<leader>gh", group = "[git] hunks" },
          { "<leader>q", group = "Quit/Session" },
          { "<leader>s", group = "Search" },
          { "<leader>u", group = "Ui" },
          { "<leader>w", group = "Windows" },
          { "<leader>x", group = "Diagnostics/Quickfix" },
          { "<leader>i", group = "Info" },
          { "<leader>l", group = "Lazy" },
          { "[", group = "★ prev" },
          { "]", group = "★ next" },
          { "g", group = "★ goto" },
          { "gs", group = "★ surround" },
          { "z", group = "★ fold" },
        },
      },
      ---@type wk.Win
      win = {
        height = { min = 3, max = 25 },
        padding = { 2, 1 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        wo = { winblend = 0 },
        border = border,
      },
      sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase", "desc" },
      preset = "modern",
      layout = {
        width = { min = 25, max = 50 },
        align = "center",
        spacing = 5,
      },
      icons = {
        separator = divider .. " ",
        group = " 󰜴 ",
        colors = false,
        rules = map_icons,
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "[which-key] Local Keymaps Buffer",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
