return {
  { import = "lazyvim.plugins.extras.lang.php" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "phpdoc" },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "olimorris/neotest-phpunit" },
    opts = {
      adapters = {
        ["neotest-phpunit"] = {},
      },
    },
  },
}
