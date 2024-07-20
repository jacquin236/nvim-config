return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-python" },
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          args = { "--log-level", "INFO", "--color", "yes", "-vv", "-s" },
          dap = { justMyCode = false },
        },
      },
    },
  },
}
