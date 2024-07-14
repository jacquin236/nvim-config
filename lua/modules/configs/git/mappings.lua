return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>G", group = "github", icon = " " },
        -- gist
        { "<leader>Gg", group = "gist", icon = " " },
        { "<leader>Ggc", group = "[gist] create", icon = " " },
        { "<leader>Ggf", group = "[gist] create from file", icon = " " },
        { "<leader>Ggl", group = "[gist] list all", icon = " " },

        -- repo
        { "<leader>GR", group = "repo", icon = " " },
        -- openingh
        { "<leader>GRa", group = "[openingh] open git repo in web", icon = "󰖟 " },
        { "<leader>GRb", group = "[openingh] open git file in web", icon = "󰖟 " },
        { "<leader>GRc", group = "[openingh] open current line in web", icon = "󰖟 " },
        -- octo
        { "<leader>Gc", group = "comments", icon = " " },
        { "<leader>Gt", group = "threads", icon = " " },
        { "<leader>Gi", group = "issues", icon = " " },
        { "<leader>Gp", group = "pull requests", icon = " " },
        { "<leader>Ga", group = "assignee/reviewer", icon = " " },
        { "<leader>Gl", group = "label", icon = " " },
        { "<leader>Gr", group = "reaction", icon = "🙀" },
        { "<leader>Gv", group = "re[v]iew", icon = " " },
        { "<leader>Gx", group = "list actions", icon = " " },
        { "<leader>Gs", group = "search for issues and PRs", icon = " " },
        { "<leader>Gpm", group = "[octo] PR merge", icon = " " },

        { "<leader>gC", group = "[git] conflicts", icon = " " },
        { "<leader>gl", group = "[git] lazygit", icon = " " },
        { "<leader>gn", group = "[git] neogit", icon = " " },
        { "<leader>gw", group = "[git] worktrees", icon = "󰙅 " },
        { "<leader>gh", group = "[git] hunks", icon = " " },
        { "<leader>go", group = "[git] octo", icon = " " },
        { "<leader>gc", group = "[git] commits", icon = " " },
        { "<leader>gs", group = "[git] status", icon = "󱖫 " },
        { "<leader>gS", group = "[git] stash", icon = " " },
      },
    },
  },
}
