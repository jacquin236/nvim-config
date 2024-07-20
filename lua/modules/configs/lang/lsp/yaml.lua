vim.filetype.add({
  -- extension = {},
  -- filename = {},
  pattern = {
    -- can be comma-separated for a list of paths
    [".*/%.github/dependabot.yml"] = "dependabot",
    [".*/%.github/dependabot.yaml"] = "dependabot",
    [".*/%.github/workflows[%w/]+.*%.yml"] = "gha",
    [".*/%.github/workflows/[%w/]+.*%.yaml"] = "gha",
  },
})

-- use the yaml parser for the custom filetypes
vim.treesitter.language.register("yaml", "gha")
vim.treesitter.language.register("yaml", "dependabot")

return {
  { "b0o/SchemaStore.nvim", version = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          settings = {
            yaml = {
              keyOrdering = false,
              format = { enable = true },
              validate = true,
              hover = true,
              schemaStore = { enable = false, url = "" },
              customTags = { "!reference sequence" }, -- for gitlab-ci.yaml files
              schemas = require("schemastore").yaml.schemas(),
            },
            redhat = { telemetry = { enabled = false } },
          },
        },
      },
      setup = {
        yamlls = function()
          -- Neovim < 0.10 does not have dynamic registration for formatting
          if vim.fn.has("nvim-0.10") == 0 then
            LazyVim.lsp.on_attach(function(client, _)
              client.server_capabilities.documentFormattingProvider = true
            end, "yamlls")
          end
        end,
      },
    },
    {
      "stevearc/conform.nvim",
      dependencies = {
        {
          "williamboman/mason.nvim",
          opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "yamlfmt" })
          end,
        },
      },
      ft = { "yaml", "gha", "dependabot" },
      opts = {
        formatters_by_ft = {
          -- TODO: the default is very strict, might be good to add a config
          -- file: https://github.com/google/yamlfmt/blob/main/docs/config-file.md#basic-formatter
          -- fix:
          --   - do not remove empty lines
          yaml = { "yamlfmt" },
          gha = { "yamlfmt" },
          dependabot = { "yamlfmt" },
        },
      },
    },
  },

  { import = "modules.configs.lang.lsp.extras.jqx" },
  { import = "modules.configs.lang.lsp.extras.yaml-companion" },
}
