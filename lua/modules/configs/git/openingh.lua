return {
  "almo7aya/openingh.nvim",
  cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
  keys = {
    { "<leader>GRa", "<cmd>OpenInGHRepo<cr>", desc = "[openingh] open git repo in web", mode = { "n" } },
    { "<leader>GRb", "<cmd>OpenInGHFile<cr>", desc = "[openingh] open git file in web", mode = { "n" } },
    {
      "<leader>GRc",
      "<cmd>OpenInGHFileLines<cr>",
      desc = "[openingh] open current line in web",
      mode = { "n", "x", "v" },
    },
  },
}
