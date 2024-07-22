return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {
      prompt_func_return_type = {
        go = true,
        java = true,
        cpp = true,
        c = true,
      },
      prompt_func_param_type = {
        go = true,
        java = true,
        cpp = true,
        c = true,
      },
      show_success_message = true,
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("refactoring")
      end)
    end,
    -- stylua: ignore
    keys = {
      { "<leader>ap", function() require("refactoring").select_refactor() end, desc = "[refactoring] prompt for a refactor", mode = { "n", "x", "v" } },
      { "<leader>aI", function() require("refactoring").refactor("Inline Function") end, desc = "[refactoring] inline function", mode = { "n", "x" } },
      { "<leader>ai", function() require("refactoring").refactor("Inline Variable") end, desc = "[refactoring] inline variable", mode = { "n", "x" } },
      { "<leader>af", function() require("refactoring").refactor("Extract Function") end, desc = "[refactoring] extract function", mode = "x" },
      { "<leader>aF", function() require("refactoring").refactor("Extract Function To File") end, desc = "[refactoring] extract function to file", mode = "x" },
      { "<leader>ab", function() require("refactoring").refactor("Extract Block") end, desc = "[refactoring] extract block" },
      { "<leader>aB", function() require("refactoring").refactor("Extract Block To File") end, desc = "[refactoring] extract block to file" },

      { "<leader>aP", function() require("telescope").extensions.refactoring.refactors() end, desc = "[refactoring] telescope", mode = { "n", "x" } },
      { "<leader>dz", function() require("refactoring").debug.print_var() end, desc = "[refactoring] Print Variables", mode = { "n", "x", "v" } },
      { "<leader>dZ", function() require("refactoring").debug.cleanup() end, desc = "[refactoring] Remove Printed Variables" },
    },
  },
}
