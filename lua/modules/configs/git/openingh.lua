return {
  "almo7aya/openingh.nvim",
  cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
  keys = {
    { "<leader>GRo", "<cmd>OpenInGHRepo<CR>", desc = "Open git repo in web", mode = { "n" } },
    { "<leader>GRf", "<cmd>OpenInGHFile<CR>", desc = "Open git file in web", mode = { "n" } },
    { "<leader>GRc", "<cmd>OpenInGHFileLines<CR>", desc = "Open current line in web", mode = { "n", "x", "v" } },
  },
}
