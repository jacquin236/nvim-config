return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      jsonFormatter = "jq",
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
      backdrop = { enabled = true, blend = 0 },
    },
    -- stylua: ignore
    keys = {
      { "<leader>aS", function() require("scissors").editSnippet() end, desc = "Edit Snippets" },
      { "<leader>as", mode = { "n", "v" },                              function() require("scissors").addNewSnippet() end, desc = "Add Snippets" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>a"] = { name = " Annotation/Snippets" },
      },
    },
  },
}
