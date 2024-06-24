return {
  { import = "lazyvim.plugins.extras.linting.eslint" },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pylint",
        "typos",
        "vale",
        "selene"
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.python = opts.linters_by_ft.python or {}
      table.insert(opts.linters_by_ft.python, "pylint")

      opts.linters_by_ft["*"] = opts.linters_by_ft["*"] or {}
      table.insert(opts.linters_by_ft["*"], "typos")

      opts.linters_by_ft.markdown = opts.linters_by_ft.markdown or {}
      table.insert(opts.linters_by_ft.markdown, "vale")

      opts.linters_by_ft.lua = opts.linters_by_ft.lua or {}
      table.insert(opts.linters_by_ft.lua, "selene")

      opts.linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      }

      return opts
    end,
  },
}
