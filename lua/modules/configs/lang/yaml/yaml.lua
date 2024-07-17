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
    },
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    ft = { "yaml" },
    opts = {
      builtin_matchers = {
        kubernetes = { enabled = true },
        cloud_init = { enabled = true },
      },
      schemas = {},
      lspconfig = {
        flags = {
          debounce_text_changes = 150,
        },
        cmd = { "yaml-language-server" },
        settings = {
          yaml = {
            trace = { server = "debug" },
          },
        },
      },
    },
    config = function(_, opts)
      require("yaml-companion").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("yaml_schema")
      end)
    end,
    keys = {
      { "<leader>cy", "<cmd>Telescope yaml_schema<cr>", desc = "Yaml Schema" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>cy", group = "[yaml-companion] Yaml Schema", icon = "󰘦  " },
      },
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
}
