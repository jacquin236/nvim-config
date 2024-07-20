return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = function()
      vim.g.undotree_TreeNodeShape = ""
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_WindowLayout = 3
    end,
    keys = {
      { "<leader>fu", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>fu", group = "Undotree", icon = " " },
      },
    },
  },
}
