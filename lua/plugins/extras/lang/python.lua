-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
---@diagnostic disable: missing-fields
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

return {
  { import = "lazyvim.plugins.extras.lang.python" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        ---@type lspconfig.options.basedpyright
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportOptionalMemberAccess = "none",
                  reportUnusedVariable = "none",
                  reportUnusedCallResult = "none",
                  reportUnusedExpression = "none",
                  reportUnknownMemberType = "none",
                  reportUnknownLambdaType = "none",
                  reportUnknownParameterType = "none",
                  reportUnknownVariableTypeType = "none",
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
        ---@type lspconfig.options.pyright
        pyright = {
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
        [vim.g.lazyvim_python_ruff] = {
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end,
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "requirements",
      },
    },
  },
  {
    "MeanderingProgrammer/py-requirements.nvim",
    event = {
      "BufRead requirements.txt",
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "hrsh7th/nvim-cmp",
        dependencies = {},
        opts = function(_, opts)
          table.insert(opts.sources, { name = "py-requirements" })
        end,
      },
    },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ppu", function() require("py-requirements").upgrade() end,          desc = "Update Package" },
      { "<leader>ppi", function() require("py-requirements").show_description() end, desc = "Package Info" },
      { "<leader>ppa", function() require("py-requirements").upgrade_all() end,      desc = "Update All Packages" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>p"] = { name = " Packages/Dependencies" },
        ["<leader>pp"] = { name = "Python" },
      },
    },
  },
  {
    "jacquin236/nvim-devdocs",
    optional = true,
    opts = {
      ensure_installed = {
        "python-3.12",
      },
    },
  },
}
