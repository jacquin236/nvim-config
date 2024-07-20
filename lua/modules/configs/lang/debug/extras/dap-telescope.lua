return {
  {
    "nvim-telescope/telescope-dap.nvim",
    cond = LazyVim.has("nvim-dap"),
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("dap")
      end)
    end,
    --stylua: ignore
    keys = {
      { "<leader>dm", "<cmd>Telescope dap commands<cr>", desc = "[telescope] commands" },
      { "<leader>df", "<cmd>Telescope dap frames<cr>", desc = "[telescope] frames" },
      { "<leader>dG", "<cmd>Telescope dap configurations<cr>", desc = "[telescope] configurations" },
      { "<leader>dbl", "<cmd>Telescope dap list_breakpoints<cr>", desc = "[telescope] List Breakpoints" },
      { "<leader>dv", "<cmd>Telescope dap variables<cr>", desc = "[telescope] variables" },
    },
  },
}
