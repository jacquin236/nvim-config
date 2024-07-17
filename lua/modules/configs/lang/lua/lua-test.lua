return {
  {
    "nvim-neotest/neotest",
    ft = { "lua" },
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
