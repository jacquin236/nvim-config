return {
  "akinsho/git-conflict.nvim",
  opts = { default_mappings = false },
  cmd = {
    "GitConflictChooseTheirs",
    "GitConflictChooseOurs",
    "GitConflictChooseBoth",
    "GitConflictListQf",
  },
  keys = {
    { "<leader>gCt", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose [Their] Changes" },
    { "<leader>gCo", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose [Our] Changes" },
    { "<leader>gCb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose [Both] changes" },
    { "<leader>gCl", "<cmd>GitConflictListQf<cr>", desc = "Git Conflict Quicklist" },
    { "[g", "<cmd>GitConflictPrevConflict<cr>", desc = "Prev Git Conflict" },
    { "]g", "<cmd>GitConflictPrevConflict<cr>", desc = "Next Git Conflict" },
  },
}
