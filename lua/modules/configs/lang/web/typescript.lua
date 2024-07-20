return {
  {
    "yioneko/nvim-vtsls",
    opts = {
      refactor_auto_rename = true,
    },
    config = function(_, opts)
      require("vtsls").config(opts)
    end,
    cmd = {
      "VtsExec",
      "VtsRename",
    },
  },
  { "dmmulroy/ts-error-translator.nvim", opts = {} },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = { enabled = false },
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end,
          },
          init_options = {
            preferences = { disableSuggestions = true },
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = { completion = { enableServerSideFuzzyMatch = true } },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = { completeFunctionCalls = true },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          -- stylua: ignore
          keys = {
            {
              "gD", function()
                local params = vim.lsp.util.make_position_params()
                LazyVim.lsp.execute({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                  open = true,
                })
              end, desc = "[ts] Goto Source Definition",
            },
            {
              "gR", function()
                LazyVim.lsp.execute({
                  command = "typescript.findAllFileReferences",
                  arguments = { vim.uri_from_bufnr(0) },
                  open = true,
                })
              end, desc = "File References",
            },
            {
              "<leader>co", LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
            {
              "<leader>cM", LazyVim.lsp.action["source.addMissingImports.ts"],
              desc = "Add missing imports",
            },
            {
              "<leader>cu", LazyVim.lsp.action["source.removeUnused.ts"],
              desc = "Remove unused imports",
            },
            {
              "<leader>cD", LazyVim.lsp.action["source.fixAll.ts"],
              desc = "Fix all diagnostics",
            },
            {
              "<leader>cV", function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end, desc = "Select TS workspace version",
            },
          },
        },
      },
    },
  },
  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "typescriptreact" },
    cmd = { "TSC", "TSCOpen", "TSCClose", "TSStop" },
    keys = {
      { "<leader>ct", ft = { "typescript", "typescriptreact" }, "<cmd>TSC<cr>", desc = "Type Check" },
      { "<leader>xy", ft = { "typescript", "typescriptreact" }, "<cmd>TSCOpen<cr>", desc = "Type Check Quickfix" },
    },
    opts = {
      auto_start_watch_mode = false,
      use_trouble_qflist = true,
      flags = { watch = false },
    },
  },
}
