if lazyvim_docs then
  -- LSP Server to use for Python.
  -- Set to "basedpyright" to use basedpyright instead of pyright.
  vim.g.lazyvim_python_lsp = "pyright"
  vim.g.lazyvim_python_ruff = "ruff_lsp"
end

local lsp = vim.g.lazyvim_python_lsp or "pyright"
local ruff = vim.g.lazyvim_python_ruff or "ruff_lsp"

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          enabled = lsp == "pyright",
          root_dir = function(fname)
            local root_files = {
              "pyproject.toml",
              "requirements.txt",
              "pyrightconfig.json",
              ".git",
            }
            return require("lspconfig").util.root_pattern(unpack(root_files))(fname)
          end,
          settings = {
            verboseOutput = true,
            autoImportCompletion = true,
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportWildcardImportFromLibrary = "none",
                  reportUnusedImport = "information",
                  reportUnusedClass = "information",
                  reportUnusedFunction = "information",
                  reportGeneralTypeIssues = "information",
                  reportPrivateImportUsage = "information",
                  reportOptionalOperand = "information",
                  reportOptionalSubscript = "information",
                  reportOptionalMemberAccess = "information",
                },
                typeCheckingMode = "strict",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                indexing = true,
              },
            },
          },
        },
        basedpyright = {
          enabled = lsp == "basedpyright",
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
                diagnosticSeverityOverrides = {
                  reportOptionalMemberAccess = "none",
                  reportUnusedCallResult = "information",
                  reportUnusedExpression = "information",
                  reportUnknownMemberType = "none",
                  reportUnknownLambdaType = "none",
                  reportUnknownParameterType = "none",
                  reportMissingParameterType = "none",
                  reportMissingTypeStub = "information",
                  reportUnknownVariableType = "none",
                  reportUnknownArgumentType = "none",
                  reportImplicitOverride = "none",
                  reportAny = "none",
                },
              },
            },
          },
        },
        [lsp] = { enabled = true },
        ruff_lsp = { enabled = ruff == "ruff_lsp" },
        ruff = { enabled = ruff == "ruff" },
        [ruff] = {
          keys = {
            { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end,
          },
        },
      },
      setup = {
        [ruff] = function()
          LazyVim.lsp.on_attach(function(client, _)
            -- Disable hover in favor of pyright
            client.server_capabilities.hoverProvider = false
          end, ruff)
        end,
      },
    },
  },
}
