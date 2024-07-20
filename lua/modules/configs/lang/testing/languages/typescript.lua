return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "adrigzr/neotest-mocha",
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        ["neotest-mocha"] = {
          command = "npm test --",
          command_args = function(context)
            return {
              "--full-trace",
              "--reporter=json",
              "--reporter-options=output=" .. context.results_path,
              "--grep=" .. context.test_name_pattern,
              context.path,
            }
          end,
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>tw", function() require('neotest').run.run({ jestCommand = 'jest --watch ' }) end, desc = "[jest] Run Watch" },
    },
  },
}
