return {
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lang.python" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "jsborjesson/vim-uppercase-sql", ft = { "sql", "mysql", "plsql" } },
    },
    keys = {
      { "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "Add Connection" },
      { "<leader>Du", "<cmd>DBUIToggle<cr>",        desc = "Toggle DBUI" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>",    desc = "Find Buffer" },
      { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>",  desc = "Rename Buffer" },
      { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
    }
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>D"] = { name = " Database" },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "sqlls" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { sqlls = {} } },
  }
}
