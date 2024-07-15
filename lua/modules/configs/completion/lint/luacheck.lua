return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "luacheck" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.lua = opts.linters_by_ft.lua or {}
      table.insert(opts.linters_by_ft.lua, "luacheck")

      opts.linters = {
        luacheck = {
          condition = function(ctx)
            return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      }

      return opts
    end,
  },
}
