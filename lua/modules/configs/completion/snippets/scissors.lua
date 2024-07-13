return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "rcarriga/nvim-notify" },
    -- stylua: ignore 
    keys = {
      { "<leader>aS", function() require("scissors").editSnippet() end, desc = "[scissors] Edit Snippets" },
      { "<leader>as", function() require("scissors").addnewSnippet() end, desc = "[scissors] Add Snippets" },
    },
  },
}
