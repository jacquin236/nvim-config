return {
  "Rawnly/gist.nvim",
  cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
  dependencies = {
    "samjwill/nvim-unception",
    init = function()
      vim.g.unception_block_while_host_edits = true
    end,
  },
  opts = {
    list = {
      mappings = {
        next_file = "<A-l>",
        prev_file = "<A-h>",
      },
    },
  },
  keys = {
    { "<leader>Ggc", "<cmd>GistCreate<cr>", desc = "[gist] create" },
    { "<leader>Ggf", "<cmd>GistCreateFromFile<cr>", desc = "[gist] create from file" },
    { "<leader>Ggl", "<cmd>GistsList<cr>", desc = "[gist] list all" },
  },
}
