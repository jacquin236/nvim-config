return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rustywind",
      },
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
        ["javascript"] = { "rustywind" },
        ["javascriptreact"] = { "rustywind" },
        ["typescript"] = { "rustywind" },
        ["typescriptreact"] = { "rustywind" },
        ["vue"] = { "rustywind" },
        ["html"] = { "rustywind" },
      })
    end,
  },
}
