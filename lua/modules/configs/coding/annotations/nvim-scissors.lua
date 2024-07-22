return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "rcarriga/nvim-notify" },
    -- stylua: ignore
    keys = {
      { "<leader>as", function() require("scissors").editSnippet() end, desc = "[scissors] edit snippets" },
      { "<leader>aS", function() require("scissors").addnewSnippet() end, desc = "[scissors] add snippets" },
    },
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets/vscode",
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>as", group = "[scissors] edit snippets", icon = "󱇧" },
        { "<leader>aS", group = "[scissors] add snippets", icon = " " },
      },
    },
  },
}
