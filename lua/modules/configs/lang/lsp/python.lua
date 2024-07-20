return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "ninja",
        "rst",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "ruff", "mypy" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
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
        ruff = {
          keys = {
            { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
          },
          handlers = { ["textDocument/publishDiagnostics"] = function() end },
        },
      },
      setup = {
        ruff = function()
          LazyVim.lsp.on_attach(function(client, _)
            -- Disable hover in favor of pyright
            client.server_capabilities.hoverProvider = false
          end, "ruff")
        end,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local mypy_path = prefer_bin_from_venv("mypy")
      opts.linters_by_ft["python"] = { "mypy" }
      if mypy_path then
        opts.linters["mypy"] = {
          cmd = prefer_bin_from_venv("mypy"),
        }
      end
    end,
  },
  { -- Overlay cell marker & metadata so it's less distracting
    "echasnovski/mini.hipatterns",
    ft = { "python" },
    opts = function(_, opts)
      local censor_extmark_opts = function(buf_id, match, data)
        local mask = string.rep("⎯", vim.api.nvim_win_get_width(0))
        return {
          virt_text = { { mask, "SignColumn" } },
          virt_text_pos = "overlay",
          virt_text_hide = true,
          -- virt_text_win_col = 5,
          priority = 200,
          right_gravity = false,
        }
      end
      opts.highlighters["cell_marker"] = {
        pattern = function(bufid)
          -- local cms = vim.api.nvim_get_option_value("commentstring", { buf = bufid })
          -- return "^" .. string.gsub(cms, [[%s]], "") .. [[%%.*]]
          return "^# *%%"
        end,
        group = "",
        extmark_opts = censor_extmark_opts,
      }
    end,
  },

  { import = "modules.configs.lang.lsp.extras.py-requirements" },
  { import = "modules.configs.lang.lsp.extras.custom-ai-python" },
}
