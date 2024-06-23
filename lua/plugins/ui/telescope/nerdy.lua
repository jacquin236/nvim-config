return {
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("nerdy")
      end)
    end,
    keys = {
      { "<leader>fi", "<cmd>Telescope nerdy<cr>", desc = "Nerdy Pick Icons" },
    },
  },
}
