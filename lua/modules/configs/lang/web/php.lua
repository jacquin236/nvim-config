return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "php", "phpdoc" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        phpactor = {},
        intelephense = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "phpcs", "php-cs-fixer" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = { "phpcs" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
    },
  },
}
