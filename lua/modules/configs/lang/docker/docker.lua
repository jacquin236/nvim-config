return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "dockerfile" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "hadolint" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = { dockerfile = { "hadolint" } },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {
          root_dir = require("lspconfig.util").root_pattern("docker-compose.yml"),
          filetypes = { "yaml", "dockerfile" },
        },
      },
    },
  },
}
