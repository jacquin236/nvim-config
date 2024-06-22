return {
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    opts = {},
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = "tpope/vim-dadbod",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
    end,
  },
  {
    "tpope/vim-eunuch",
    cmd = { "Move", "Rename", "Remove", "Delete", "Mkdir" },
  },
  { "tpope/vim-sleuth", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "vuki656/package-info.nvim",
    event = "BufRead package.json",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
}
