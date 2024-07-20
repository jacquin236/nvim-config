vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})
return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>Ss", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<leader>St", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<leader>Sp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<leader>Sn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "http" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>S", group = "server/client", icon = "󰖟 " },
      },
    },
  },
}
