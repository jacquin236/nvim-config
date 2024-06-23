return {
  {
    "debugloop/telescope-undo.nvim",
    lazy = true,
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup({
          extensions = {
            undo = {
              side_by_sdie = true,
              layout_strategy = "vertical",
              layout_config = {
                preview_height = 0.6,
              },
            },
          },
        })

        require("telescope").load_extension("undo")
      end)
    end,
    keys = {
      { "<leader>uT", "<cmd>Telescope undo<cr>", desc = "Undotree Telescope" },
    },
  },
}
