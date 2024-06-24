return {
  { import = "plugins.extras.lang.typescript" },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "graphql-language-service-cli" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        graphql = {
          filetypes = { "graphql", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
      },
    },
  },
}
