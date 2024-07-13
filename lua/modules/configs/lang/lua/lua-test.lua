return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      { "nvim-neotest/neotest-plenary" },
    },
    opts = {
      adapters = {
        ["neotest-plenary"] = {},
      },
    },
  },
}
