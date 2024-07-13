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
        { "<leader>cy", group = "Yaml Schema", icon = "󰘦 " },
      },
    },
  },
}
