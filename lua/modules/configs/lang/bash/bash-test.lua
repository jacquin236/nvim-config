return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "rcasia/neotest-bash" },
    opts = {
      adapters = {
        ["neotest-bash"] = {},
      },
    },
  },
}
