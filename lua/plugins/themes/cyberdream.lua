return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    config = function()
      require("cyberdream").setup({
        transparent = true,
        italic_comments = true,
        borderless_telescope = false,
        terminal_colors = true,
        theme = {
          variant = "dark",
        },
      })
    end,
  },
}
