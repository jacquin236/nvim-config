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
      { "<leader>sia", "<cmd>IconPickerNormal<cr>",              desc = "All" },
      { "<leader>sis", "<cmd>IconPickerNormal symbols<cr>",      desc = "Symbols" },
      { "<leader>sie", "<cmd>IconPickerNormal emoji<cr>",        desc = "Emoji" },
      { "<leader>sin", "<cmd>IconPickerNormal nerd_font_v3<cr>", desc = "Nerd Fonts" },
    },
  },
  {
    "2kabhishek/nerdy.nvim",
    optional = true,
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("nerdy")
      end)
    end,
    keys = {
      { "<leader>sif", "<cmd>Telescope nerdy<cr>", desc = "Nerdy Icons" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>si"] = { name = "Icons" },
      },
    },
  },
}
