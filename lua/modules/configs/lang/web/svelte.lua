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
    opts = { ensure_installed = { "svelte" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svelte = {
          root_dir = function(...)
            return require("lspconfig").util.root_pattern("svelte.config.js", "svelte.config.mjs", "svelte.config.cjs")(
              ...
            )
          end,
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
          capabilities = {
            workspace = {
              didChangeWatchedFiles = vim.fn.has("nvim-0.10") == 0 and { dynamicRegistration = true },
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
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "typescript-svelte-plugin",
          location = LazyVim.get_pkg_path("svelte-language-server", "/node_modules/typescript-svelte-plugin"),
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },

  {
    "conform.nvim",
    opts = function(_, opts)
      if LazyVim.has_extra("formatting.prettier") then
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        opts.formatters_by_ft.svelte = { "prettier" }
      end
    end,
  },
}
