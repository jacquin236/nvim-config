return {
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    vscode = true,
    opts = {},
    --stylua: ignore
    keys = {
      { "J", "<cmd>NodeAction<cr>", mode = "n", desc = "Node action" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "J", group = "Node action", icon = "󰭅 " },
      },
    },
  },
}
