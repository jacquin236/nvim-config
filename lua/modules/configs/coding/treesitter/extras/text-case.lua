return {
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {},
    config = function(_, opts)
      require("textcase").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("textcase")
      end)
    end,
    keys = {
      { "<leader>gC", "<cmd>TestCaseOpenTelescope<cr>", mode = { "n", "x" }, desc = "Text Case" },
    },
    cmd = {
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
  },
}
