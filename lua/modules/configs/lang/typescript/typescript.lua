return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "dmmulroy/ts-error-translator.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end,
          },
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
        },
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
