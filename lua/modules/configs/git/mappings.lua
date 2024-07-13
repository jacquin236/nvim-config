return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>G", group = "github", icon = " " },
        { "<leader>Gg", group = "gist", icon = " " },
        { "<leader>GR", group = "repo", icon = " " },
        { "<leader>Gc", group = "[octo] comments" },
        { "<leader>Gt", group = "[octo] threads" },
        { "<leader>Gi", group = "[octo] issues" },
        { "<leader>Gp", group = "[octo] pull requests" },
        { "<leader>Ga", group = "[octo] assignee/reviewer" },
        { "<leader>Gl", group = "[octo] label" },
        { "<leader>Gr", group = "[octo] reaction" },
        { "<leader>Gv", group = "[octo] re[v]iew" },
        { "<leader>Gpm", group = "Merge Current PR" },

        { "<leader>gC", group = "[git] conflicts", icon = " " },
        { "<leader>gl", group = "[git] lazygit", icon = " " },
        { "<leader>gn", group = "[git] neogit", icon = " " },
        { "<leader>gw", group = "[git] worktrees", icon = "󰙅 " },
      },
    },
  },
}
