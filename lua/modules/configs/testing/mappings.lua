return {
  {
    "nvim-neotest/neotest",
    -- stylua: ignore
    keys = {
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "[test] Attach" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[test] Run File" },
      { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[test] Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "[test] Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "[test] Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[test] Summary" },
      { "<leader>tS", function() require("neotest").run.run({ suite = true }) end, desc = "[test] Suite" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[test] Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[test] Output Panel" },
      { "<leader>tt", function() require("neotest").run.stop() end, desc = "[test] Terminate" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "[test] Toggle Watch" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>t"] = { name = " Test" },
      },
    },
  },
}
