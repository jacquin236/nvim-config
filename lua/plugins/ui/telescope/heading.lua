return {
  {
    "crispgm/telescope-heading.nvim",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup({
          extensions = { heading = { treesitter = true } },
        })
        require("telescope").load_extension("heading")
      end)
    end,
    keys = {
      { "<leader>m", "<cmd>Telescope heading<cr>", desc = "Markdown: Headings" },
    },
  },
}
