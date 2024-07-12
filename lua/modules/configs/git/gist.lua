return {
  "Rawnly/gist.nvim",
  cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
  dependencies = {
    "samjwill/nvim-unception",
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
  opts = {},
  keys = {
    { "<leader>Ggc", "<cmd>GistCreate<cr>", desc = "Create a Gist" },
    { "<leader>Ggf", "<cmd>GistCreateFromFile<cr>", desc = "Create a Gist from file" },
    { "<leader>Ggl", "<cmd>GistsList<cr>", desc = "List Gists" },
  },
}
