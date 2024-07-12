return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>g"] = { name = " Git" },
        ["<leader>gC"] = { name = "[git] conflicts" },
        ["<leader>gl"] = { name = "[git] lazygit" },
        ["<leader>gn"] = { name = "[git] neogit" },
        ["<leader>gw"] = { name = "[git] worktrees" },

        ["<leader>G"] = { name = " Github" },
        ["<leader>Gg"] = { name = "gist" },
        ["<leader>GR"] = { name = "repo" },
        ["<leader>Gc"] = { name = "[octo] comments" },
        ["<leader>Gt"] = { name = "[octo] threads" },
        ["<leader>Gi"] = { name = "[octo] issues" },
        ["<leader>Gp"] = { name = "[octo] pull requests" },
        ["<leader>Ga"] = { name = "[octo] assignee/reviewer" },
        ["<leader>Gl"] = { name = "[octo] label" },
        ["<leader>Gr"] = { name = "[octo] reaction" },
        ["<leader>Gv"] = { name = "[octo] re[v]iew" },
        ["<leader>Gpm"] = { name = "Merge Current PR" },
      },
    },
  },
}
