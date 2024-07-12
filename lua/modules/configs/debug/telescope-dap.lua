return {
  {
    "nvim-telescope/telescope-dap.nvim",
    cond = LazyVim.has "nvim-dap",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension "dap"
      end)
    end,
    --stylua: ignore
    keys = {
      { "<leader>dm", "<cmd>Telescope dap commands<cr>", desc = "[telescope-dap] commands" },
      { "<leader>df", "<cmd>Telescope dap frames<cr>", desc = "[telescope-dap] frames" },
      { "<leader>dG", "<cmd>Telescope dap configurations<cr>", desc = "[telescope-dap] configurations" },
      { "<leader>dbl", "<cmd>Telescope dap list_breakpoints<cr>", desc = "[telescope-dap] List Breakpoints" },
      { "<leader>dv", "<cmd>Telescope dap variables<cr>", desc = "[telescope-dap] variables" },
    },
  },
}
