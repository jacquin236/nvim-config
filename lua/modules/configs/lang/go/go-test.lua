return {
  {
    "nvim-neotest/neotest",
    dependencies = { "fredrikaverpil/neotest-golang", "leoluz/nvim-dap-go" },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-golang"] = {
        go_test_args = {
          "-v",
          "-race",
          "-parallel=1",
          "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
        },
        dap_go_enabled = true,

        -- experimental
        dev_notifications = true,
        runner = "gotestsum",
        gotestsum_args = { "--format=standard-verbose" },
      }
    end,
  },
  {
    "andythigpen/nvim-coverage",
    ft = { "go" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      auto_reload = true,
      lang = {
        go = { coverage_file = vim.fn.getcwd() .. "/coverage.out" },
      },
    },
  },
}
