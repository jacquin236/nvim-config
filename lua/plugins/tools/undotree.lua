return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>ut", "<cmd>UndotreeToggle<cr>", desc = "Undotree Toggle" },
    },
    config = function()
      vim.g.undotree_TreeNodeShape = "◉"
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "simnalamburt/vim-mundo",
    cmd = "MundoToggle",
    keys = {
      { "<leader>uu", "<cmd>MundoToggle<cr>", desc = "Undotree Mundo" },
    },
  },
}
