return {
  {
    "glepnir/template.nvim",
    cmd = {
      "Template",
      "TemProject",
    },
    config = function()
      require("template").setup({
        temp_dir = "~/.config/nvim/templates",
        author = "Jacquin Moon",
        email = "jacquin236@gmail.com",
      })
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("find_template")
      end)

      vim.keymap.set("n", "<leader>Pt", function()
        vim.fn.feedkeys(":Template ")
      end, { remap = true, desc = "Template" })
    end,
  },
}
