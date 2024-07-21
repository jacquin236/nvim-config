return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "rcarriga/nvim-notify" },
    -- stylua: ignore
    keys = {
      { "<leader>ae", function() require("scissors").editSnippet() end, desc = "[scissors] edit snippets" },
      { "<leader>aa", function() require("scissors").addnewSnippet() end, desc = "[scissors] add snippets" },
    },
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets/vscode",
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>ae", group = "[scissors] edit snippets", icon = "󱇧" },
        { "<leader>aa", group = "[scissors] add snippets", icon = " " },
      },
    },
  },
}
