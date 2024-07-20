return {
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
        { "<leader>cy", group = "Yaml Schema", icon = "󰘦  " },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local function yaml_schema()
        local schema = require("yaml-companion").get_buf_schema(0)
        if schema.result[1].name == "none" then
          return ""
        end
        return schema.result[1].name
      end
      table.insert(opts.sections.lualine_x, 1, yaml_schema)
    end,
  },
}
