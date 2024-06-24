return {
  {
    "andrew-george/telescope-themes",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup({
          extensions = {
            themes = {
              layout_strategy = "horizontal",
              layout_config = {
                horizontal = { preview_width = 0.5 },
                width = 0.8,
                height = 0.8,
                preview_cutoff = 120,
              },
              enable_previewer = true,
              ignore = {
                "blue",
                "darkblue",
                "default",
                "delek",
                "desert",
                "elflord",
                "evening",
                "industry",
                "lunaperche",
                "morning",
                "murphy",
                "pablo",
                "peachpuff",
                "retrobox",
                "ron",
                "shine",
                "slate",
                "torte",
                "zellner",
              },
            },
          },
        })
        require("telescope").load_extension("themes")
      end)
    end,
    keys = {
      { "<leader>uS", "<cmd>Telescope themes<cr>", desc = "Toggle Themes" },
    },
  },
}
