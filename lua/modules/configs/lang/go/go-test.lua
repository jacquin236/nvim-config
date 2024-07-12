return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      {
        "fredrikaverpil/neotest-golang",
        dependencies = { "leoluz/nvim-dap-go" },
        branch = "main",
      },
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          go_test_args = {
            "-v",
            "-race",
            "-timeout=60s",
            "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
          },
          dap_go_enabled = true,
        },
      },
    },
  },
}
