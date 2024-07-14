return {
  { import = "lazyvim.plugins.extras.util.octo" },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    opts = {
      mappings = {},
    },
    -- stylua: ignore
    keys = {
      -- issues
      { "<leader>Gil", "<cmd>Octo issue list<cr>", desc = "[octo] list issues" },
      { "<leader>Gis", "<cmd>Octo issue search<cr>", desc = "[octo] search issues" },
      { "<leader>Gic", "<cmd>Octo issue close<cr>", desc = "[octo] close issue" },
      { "<leader>Gir", "<cmd>Octo issue reopen<cr>", desc = "[octo] reopen issue" },
      { "<leader>Gie", "<cmd>Octo issue edit<cr>", desc = "[octo] edit issue <number> in repo" },
      { "<leader>Gil", "<cmd>Octo issue list<cr>", desc = "[octo] list issues" },
      { "<leader>Giu", "<cmd>Octo issue url<cr>", desc = "[octo] copy url of issue" },
      { "<leader>GiR", "<cmd>Octo issue reload<cr>", desc = "[octo] reload issue" },
      { "<leader>GiC", "<cmd>Octo issue create<cr>", desc = "[octo] create new issue" },

      -- pull requests
      { "<leader>Gpl", "<cmd>Octo pr list<cr>", desc = "[octo] list all PRs" },
      { "<leader>Gps", "<cmd>Octo pr search<cr>", desc = "[octo] search PRs" },
      { "<leader>Gpe", "<cmd>Octo pr edit<cr>", desc = "[octo] edit PR <number> in repo" },
      { "<leader>Gpr", "<cmd>Octo pr reopen<cr>", desc = "[octo] reopen PR" },
      { "<leader>GpC", "<cmd>Octo pr create<cr>", desc = "[octo] create new PR" },
      { "<leader>Gpc", "<cmd>Octo pr close<cr>", desc = "[octo] close PR" },
      { "<leader>Gpk", "<cmd>Octo pr checkout<cr>", desc = "[octo] checkout PR" },
      { "<leader>Gpo", "<cmd>Octo pr commits<cr>", desc = "[octo] list PR commits" },
      { "<leader>Gpd", "<cmd>Octo pr changes<cr>", desc = "[octo] show PR changes (diff hunks)" },
      { "<leader>GpD", "<cmd>Octo pr diff<cr>", desc = "[octo] show PR diff" },
      { "<leader>Gpy", "<cmd>Octo pr ready<cr>", desc = "[octo] mark draft PR ready for review" },
      { "<leader>GpK", "<cmd>Octo pr checks<cr>", desc = "[octo] show status of all checks run on PR" },
      { "<leader>GpR", "<cmd>Octo pr reload<cr>", desc = "[octo] reload" },
      { "<leader>Gpb", "<cmd>Octo pr browser<cr>", desc = "[octo] open PR in browser" },
      { "<leader>Gpu", "<cmd>Octo pr url<cr>", desc = "[octo] copy url of PR" },
      -- merge PRs
      { "<leader>Gpmo", "<cmd>Octo pr merge commit<cr>", desc = "PR merge commit" },
      { "<leader>Gpms", "<cmd>Octo pr merge squash<cr>", desc = "PR merge squash" },
      { "<leader>Gpmd", "<cmd>Octo pr merge delete<cr>", desc = "PR merge delete" },
      { "<leader>Gpmr", "<cmd>Octo pr merge rebase<cr>", desc = "PR merge rebase" },

      -- repo
      { "<leader>GRl", "<cmd>Octo repo list<cr>", desc = "[octo] list repo user stats" },
      { "<leader>GRk", "<cmd>Octo repo fork<cr>", desc = "[octo] folk repo" },
      { "<leader>GRu", "<cmd>Octo repo url<cr>", desc = "[octo] copy url of repo" },
      { "<leader>GRv", "<cmd>Octo repo view<cr>", desc = "[octo] open a repo by path ({organization}/{name})" },

      -- comments
      { "<leader>Gca", "<cmd>Octo comment add<cr>", desc = "[octo] add comment" },
      { "<leader>Gcd", "<cmd>Octo comment delete<cr>", desc = "[octo] delete comment" },

      -- threads
      { "<leader>Gtr", "<cmd>Octo thread resolve<cr>", desc = "[octo] mark review thread as resolved" },
      { "<leader>Gtu", "<cmd>Octo thread unresolve<cr>", desc = "[octo] mark review thread as unresolved" },

      -- labels
      { "<leader>Gla", "<cmd>Octo label add<cr>", desc = "[octo] add label" },
      { "<leader>Glr", "<cmd>Octo label remove<cr>", desc = "[octo] remove label" },
      { "<leader>GlC", "<cmd>Octo label create<cr>", desc = "[octo] create label" },

      -- assignee/reviewer
      { "<leader>Gaa", "<cmd>Octo assignee add<cr>", desc = "[octo] assign a user" },
      { "<leader>Gar", "<cmd>Octo assignee remove<cr>", desc = "[octo] unassign a user" },
      { "<leader>Gaw", "<cmd>Octo reviewer add<cr>", desc = "[octo] assign a PR reviewer" },

      -- reaction
      { "<leader>Gr1", "<cmd>Octo reaction thumbs_up<cr>", desc = "[octo] add 👍" },
      { "<leader>Gr2", "<cmd>Octo reaction thumbs_down<cr>", desc = "[octo] add 👎" },
      { "<leader>Gr3", "<cmd>Octo reaction eyes<cr>", desc = "[octo] add 👀" },
      { "<leader>Gr4", "<cmd>Octo reaction laugh<cr>", desc = "[octo] add 😄" },
      { "<leader>Gr5", "<cmd>Octo reaction confused<cr>", desc = "[octo] add 😕" },
      { "<leader>Gr6", "<cmd>Octo reaction rocket<cr>", desc = "[octo] add 🚀" },
      { "<leader>Gr7", "<cmd>Octo reaction heart<cr>", desc = "[octo] add ❤️ " },
      { "<leader>Gr8", "<cmd>Octo reaction party<cr>", desc = "[octo] add 🎉" },

      -- review
      { "<leader>Gva", "<cmd>Octo review start<cr>", desc = "[octo] start new review" },
      { "<leader>Gvs", "<cmd>Octo review submit<cr>", desc = "[octo] submit review" },
      { "<leader>Gvr", "<cmd>Octo review resume<cr>", desc = "[octo] edit pending review" },
      { "<leader>Gvd", "<cmd>Octo review discard<cr>", desc = "[octo] delete pending review" },
      { "<leader>Gvc", "<cmd>Octo review comments<cr>", desc = "[octo] view pending review comments" },
      { "<leader>Gvp", "<cmd>Octo review commit<cr>", desc = "[octo] pick a commit to review" },
      { "<leader>GvR", "<cmd>Octo review close<cr>", desc = "[octo] close review window & return to PR" },

      -- actions
      { "<leader>Gx", "<cmd>Octo actions<cr>", desc = "[octo] list available actions" },
      -- search
      { "<leader>Gs", "<cmd>Octo search<cr>", desc = "[octo] search for issues and PRs" },

      { "<leader>gi", false },
      { "<leader>gI", false },
      { "<leader>gp", false },
      { "<leader>gP", false },
      { "<leader>gr", false },
      { "<leader>gS", false },
      { "<leader>goi", "<cmd>Octo issue list<cr>", desc = "[octo] list issues" },
      { "<leader>goI", "<cmd>Octo issue search<CR>", desc = "[octo] search issues" },
      { "<leader>gop", "<cmd>Octo pr list<CR>", desc = "[octo] list PRs" },
      { "<leader>goP", "<cmd>Octo pr search<CR>", desc = "[octo] search PRs" },
      { "<leader>gor", "<cmd>Octo repo list<CR>", desc = "[octo] list repos" },
      { "<leader>gos", "<cmd>Octo search<CR>", desc = "[octo] search" },
    },
  },
}
