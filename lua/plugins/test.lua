return {
  {
    "nvim-neotest/neotest",
    keys = {
      { "<leader>t", "", desc = "+test" },
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.uv.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tF",
        function()
          require("neotest").run.run({ vim.fn.expand("%"), concurrent = false })
        end,
        desc = "Run File Synchronously",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop({ interactive = true })
        end,
        desc = "Stop",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Toggle Watch",
      },
      {
        "<leader>tf",
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Jump to Next Failed Test",
      },
      {
        "<leader>tp",
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Jump to Prev Failed Test",
      },
    },
    config = function()
      local namespace = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          end,
        },
      }, namespace)

      require("neotest").setup({
        discovery = { enabled = true },
        diagnostic = { enabled = true },
        floating = { border = require("util.ui").border },
        quickfix = { enabled = false, open = true },
        adapters = {
          require("neotest-plenary"),
          require("neotest-go"),
          require("neotest-rust")({
            args = { "--verbose" },
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
          }),
        },
      })
    end,
    dependencies = {
      { "rouge8/neotest-rust" },
      { "haydenmeade/neotest-jest" },
      { "nvim-neotest/neotest-go", dev = true },
      { "rcarriga/neotest-plenary", dependencies = { "nvim-lua/plenary.nvim" } },
    },
  },
}
