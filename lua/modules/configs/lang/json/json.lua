local filetypes = { "json", "jsonc", "json5" }

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
  pattern = filetypes,
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

return {
  { "b0o/SchemaStore.nvim", version = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = {
          filetypes = filetypes,
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
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
          vim.list_extend(opts.ensure_installed, { "biome" })
        end,
      },
    },
    ft = filetypes,
    opts = {
      formatters_by_ft = {
        json = { "biome" },
        jsonc = { "biome" },
        json5 = { "biome" },
      },
      formatters = {
        biome = {
          -- https://biomejs.dev/formatter/
          args = { "format", "--indent-style", "space", "--stdin-file-path", "$FILENAME" },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json", "jsonc", "json5" } },
  },
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
    cmd = { "JqxList", "JqxQuery" },
    keys = {
      { "<leader>cj", ft = { "json", "yaml" }, "<cmd>JqxList<cr>", desc = "Jqx List" },
    },
  },
}
