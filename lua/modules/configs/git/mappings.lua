return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>G", group = "Github" },
        { "<leader>Gg", group = "Gist" },
        { "<leader>GR", group = "Repo" },
        { "<leader>Gc", group = "[octo] comments" },
        { "<leader>Gt", group = "[octo] threads" },
        { "<leader>Gi", group = "[octo] issues" },
        { "<leader>Gp", group = "[octo] pull requests" },
        { "<leader>Ga", group = "[octo] assignee/reviewer" },
        { "<leader>Gl", group = "[octo] label" },
        { "<leader>Gr", group = "[octo] reaction" },
        { "<leader>Gv", group = "[octo] re[v]iew" },
        { "<leader>Gpm", group = "Merge Current PR" },

        { "<leader>gC", group = "[git] conflicts" },
        { "<leader>gl", group = "[git] lazygit" },
        { "<leader>gn", group = "[git] neogit" },
        { "<leader>gw", group = "[git] worktrees" },
      },
    },
  },
}
