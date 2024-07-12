return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "golangci-lint", "goimports", "gofumpt" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local function add_linters(tbl)
        for ft, linters in pairs(tbl) do
          if opts.linters_by_ft[ft] == nil then
            opts.linters_by_ft[ft] = linters
          else
            vim.list_extend(opts.linters_by_ft[ft], linters)
          end
        end
      end

      add_linters {
        ["go"] = { "golangcilint" },
        ["gomod"] = { "golangcilint" },
        ["gowork"] = { "golangcilint" },
      }

      return opts
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
    },
  },
}
