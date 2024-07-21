return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>G", group = "github", icon = " ", mode = { "n", "v" } },
        -- gist
        { "<leader>Gg", group = "gist", icon = " " },
        { "<leader>Ggc", group = "[gist] create", icon = " " },
        { "<leader>Ggf", group = "[gist] create from file", icon = " " },
        { "<leader>Ggl", group = "[gist] list all", icon = " " },

        -- repo
        { "<leader>GR", group = "repo", icon = " ", mode = { "n", "v" } },
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
        { "<leader>Gx", group = "List Actions", icon = " " },
        { "<leader>Gs", group = "Search for Issues and PRs", icon = " " },
        { "<leader>Gpm", group = "[octo] PR merge", icon = " " },

        -- git
        { "<leader>gC", group = "Git Conflicts", icon = " " },
        { "<leader>gl", group = "Lazygit", icon = " " },
        { "<leader>gn", group = "Neogit", icon = " " },
        { "<leader>gw", group = "Git Worktrees", icon = "󰙅 " },
        { "<leader>gh", group = "Git Hunks", icon = " " },
        { "<leader>go", group = "Octo", icon = " " },

        { "<leader>gc", group = "[git] commits", icon = " " },
        { "<leader>gs", group = "[git] status", icon = "󱖫 " },
        { "<leader>gS", group = "[git] stash", icon = " " },
      },
    },
  },
}
