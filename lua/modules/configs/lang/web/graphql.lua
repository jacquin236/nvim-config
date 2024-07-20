return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "graphql-language-service-cli" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "graphql" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      servers = {
        graphql = {
          filetypes = { "graphql", "javascript", "javascriptreact", "typescript", "typescriptreact" },
          on_attach = function(client)
            -- Disable workspaceSymbolProvider because this prevents
            -- searching for symbols in typescript files which this server
            -- is also enabled for.
            -- @see: https://github.com/nvim-telescope/telescope.nvim/issues/964
            client.server_capabilities.workspaceSymbolProvider = false
          end,
        },
      },
    },
  },
}
