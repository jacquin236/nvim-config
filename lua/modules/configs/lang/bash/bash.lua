vim.filetype.add({
  pattern = {
    [".*/kitty/.+%.conf"] = "bash",
    ["^.env%..*"] = "bash",
  },
})

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "bash-language-server", "shellcheck" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "bash" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.bash = opts.linters_by_ft.bash or {}
      table.insert(opts.linters_by_ft.bash, "shellcheck")
      return opts
    end,
  },
}
