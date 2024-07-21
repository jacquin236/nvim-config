vim.filetype.add({
  extension = {
    avsc = "json", -- avro
  },
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json", "jsonc", "json5" } },
  },
  {
    "b0o/SchemaStore.nvim",
    version = false, -- last release is way too old
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
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
        biome = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "biome" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local function add_formatters(tbl)
        for ft, formatters in pairs(tbl) do
          if opts.formatters_by_ft[ft] == nil then
            opts.formatters_by_ft[ft] = formatters
          else
            vim.list_extend(opts.formatters_by_ft[ft], formatters)
          end
        end
      end

      add_formatters({
        ["jsonc"] = { "biome" },
        ["json"] = { "biome" },
      })

      opts.formatters = {
        biome = {
          condition = function(_, ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
          args = { "format", "--indent-style", "space", "--stdin-file-path", "$FILENAME" },
        },
      }

      return opts
    end,
  },

  { import = "modules.configs.lang.lsp.extras.jqx" },
}
