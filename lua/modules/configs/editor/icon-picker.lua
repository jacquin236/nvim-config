return {
  {
    "ziontee113/icon-picker.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
    },
    opts = {
      disable_legacy_commands = true,
    },
  -- stylua: ignore
    keys = {
      { "<leader>cia", "<cmd>IconPickerNormal<cr>", desc = "Pick [a]ll" },
      { "<leader>cis", "<cmd>IconPickerNormal symbols<cr>", desc = "Pick [s]ymbols" },
      { "<leader>cie", "<cmd>IconPickerNormal emoji<cr>", desc = "Pick [e]moji" },
      { "<leader>cin", "<cmd>IconPickerNormal nerd_font_v3<cr>", desc = "Pick [n]erd fonts" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>ci", group = "icons", icon = " " },
      },
    },
  },
}
