return {
  {
    "glepnir/template.nvim",
    cmd = { "Template", "TemProject" },
    opts = {
      temp_dir = vim.fn.stdpath("config") .. "templates/projects",
      author = "Jacquin Moon",
      email = "jacquin236@gmail.com",
    },
    config = function(_, opts)
      require("template").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("find_template")
      end)
    end,
    keys = {
      { "<leader>Pt", "<cmd>Telescope find_template<cr>", desc = "[template] Check all templates" },
      {
        "<leader>Pi",
        "<cmd>Telescope find_template type=insert<cr>",
        desc = "[template] Select a template and insert into current bufer",
      },
    },
  },
}
