local inlay_hints_settings = {
  parameterNames = { enabled = "all" },
  parameterTypes = { enabled = true },
  variableTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  enumMemberValues = { enabled = true },
}

return {
  { import = "modules.configs.lang.web.typescript" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vue" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = inlay_hints_settings,
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = inlay_hints_settings,
            },
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end,
          },
        },
        vtsls = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      table.insert(opts.servers.vtsls.filetypes, "vue")
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@vue/typescript-plugin",
          location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },
}
