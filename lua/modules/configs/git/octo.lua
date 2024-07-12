return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      default_merge_method = "squash",
      picker = "telescope",
      use_diagnostic_signs = true,
      mappings = {},
    },
    keys = {
      { "<leader>a", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<leader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<leader>l", "", desc = "+label (Octo)", ft = "octo" },
      { "<leader>i", "", desc = "+issue (Octo)", ft = "octo" },
      { "<leader>r", "", desc = "+react (Octo)", ft = "octo" },
      { "<leader>p", "", desc = "+pr (Octo)", ft = "octo" },
      { "<leader>v", "", desc = "+review (Octo)", ft = "octo" },
      { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },

      -- comment
      { "<leader>Gca", "<cmd>Octo comment add<CR>", desc = "Add a New Comment" },
      { "<leader>Gcd", "<cmd>Octo comment delete<CR>", desc = "Delete a Comment" },

      -- thread
      { "<leader>Gta", "<cmd>Octo thread resolve<CR>", desc = "Mark Thread as Resolved" },
      { "<leader>Gtd", "<cmd>Octo thread unresolve<CR>", desc = "Mark Thread as Unresolved" },

      -- issue
      { "<leader>Gic", "<cmd>Octo issue close<CR>", desc = "Close Current Issue" },
      { "<leader>Gir", "<cmd>Octo issue reopen<CR>", desc = "Reopen Current Issue" },
      { "<leader>Gil", "<cmd>Octo issue list<CR>", desc = "List Open Issues" },
      { "<leader>Giu", "<cmd>Octo issue url<CR>", desc = "Copies URL of Current Issue" },
      { "<leader>Gio", "<cmd>Octo issue browser<CR>", desc = "Open Current Issue in Browser" },

      -- pr
      { "<leader>Gpp", "<cmd>Octo pr checkout<CR>", desc = "[octo] Checkout PR" },
      -- pr merge
      { "<leader>Gpmm", "<cmd>Octo pr merge commit<CR>", desc = "Merge Commit PR" },
      { "<leader>Gpms", "<cmd>Octo pr merge squash<CR>", desc = "Squash Merge PR" },
      { "<leader>Gpmd", "<cmd>Octo pr merge delete<CR>", desc = "Delete Merge PR" },
      { "<leader>Gpmr", "<cmd>Octo pr merge rebase<CR>", desc = "Rebase Merge PR" },

      { "<leader>Gpc", "<cmd>Octo pr close<CR>", desc = "Close Current PR" },
      { "<leader>Gpn", "<cmd>Octo pr create<CR>", desc = "Create PR for Current Branch" },
      { "<leader>Gpd", "<cmd>Octo pr diff<CR>", desc = "Show PR Diff" },
      { "<leader>Gps", "<cmd>Octo pr list<CR>", desc = "List Open PRs" },
      { "<leader>Gpr", "<cmd>Octo pr ready<CR>", desc = "Mark Draft as Ready for Review" },
      { "<leader>Gpo", "<cmd>Octo pr browser<CR>", desc = "Open Current PR in Browser" },
      { "<leader>Gpu", "<cmd>Octo pr url<CR>", desc = "Copies URL of Current PR" },
      { "<leader>Gpt", "<cmd>Octo pr commits<CR>", desc = "List PR Commits" },
      { "<leader>Gpl", "<cmd>Octo pr commits<CR>", desc = "List Changed Files in PR" },
      { "<leader>GpS", "<cmd>Octo pr search<CR>", desc = "Search PRs" },

      -- repo
      { "<leader>GRl", "<cmd>Octo repo list<CR>", desc = "[octo] List Repo User Stats" },
      { "<leader>GRf", "<cmd>Octo repo fork<CR>", desc = "[octo] Fork Repo" },
      { "<leader>GRu", "<cmd>Octo repo url<CR>", desc = "[octo] Copies URL of Current Repo" },

      -- assignee
      { "<leader>Gaa", "<cmd> Octo assignee add<CR>", desc = "Assign a User" },
      { "<leader>Gar", "<cmd> Octo assignee remove<CR>", desc = "Remove a User" },
      { "<leader>Gap", "<cmd> Octo reviewer add<CR>", desc = "Assign a PR Reviewer" },

      -- label
      { "<leader>Gla", "<cmd> Octo label add<CR>", desc = "Assign a Label" },
      { "<leader>Glr", "<cmd> Octo label remove<CR>", desc = "Remove a Label" },
      { "<leader>Glc", "<cmd> Octo label create<CR>", desc = "Create a Label" },

      -- react
      { "<leader>Gr1", "<cmd>Octo reaction thumbs_up<CR>", desc = "Add 👍 Reaction" },
      { "<leader>Gr2", "<cmd>Octo reaction thumbs_down<CR>", desc = "Add 👎 Reaction" },
      { "<leader>Gr3", "<cmd>Octo reaction eyes<CR>", desc = "Add 👀 Reaction" },
      { "<leader>Gr4", "<cmd>Octo reaction laugh<CR>", desc = "Add 😄 Reaction" },
      { "<leader>Gr5", "<cmd>Octo reaction confused<CR>", desc = "Add 😕 Reaction" },
      { "<leader>Gr6", "<cmd>Octo reaction rocket<CR>", desc = "Add 🚀 Reaction" },
      { "<leader>Gr7", "<cmd>Octo reaction heart<CR>", desc = "Add ❤️ Reaction" },
      { "<leader>Gr8", "<cmd>Octo reaction party<CR>", desc = "Add 🎉 Reaction" },

      { "<leader>Gx", "<cmd>Octo actions<CR>", desc = "[octo] Run an Action" },

      { "<leader>Gvs", "<cmd> Octo review start<CR>", desc = "Start Review" },
      { "<leader>Gvf", "<cmd> Octo review submit<CR>", desc = "Submit Review" },
      { "<leader>Gvr", "<cmd> Octo review resume<CR>", desc = "Submit Resume" },
      { "<leader>Gvd", "<cmd> Octo review discard<CR>", desc = "Delete Pending Review" },
      { "<leader>Gvc", "<cmd> Octo review comments<CR>", desc = "View Pending Comments" },
      { "<leader>Gvp", "<cmd> Octo review commit<CR>", desc = "Select Commit to Review" },
      { "<leader>Gvc", "<cmd> Octo review close<CR>", desc = "Return to PR" },
    },
  },
  -- Octo Picker
  {
    "pwntester/octo.nvim",
    opts = function(_, opts)
      vim.treesitter.language.register("markdown", "octo")
      if LazyVim.has "telescope.nvim" then
        opts.picker = "telescope"
      elseif LazyVim.has "fzf-lua" then
        opts.picker = "fzf-lua"
      else
        LazyVim.error "`octo.nvim` requires `telescope.nvim` or `fzf-lua`"
      end

      -- Keep some empty windows in sessions
      vim.api.nvim_create_autocmd("ExitPre", {
        group = vim.api.nvim_create_augroup("octo_exit_pre", { clear = true }),
        callback = function(ev)
          local keep = { "octo" }
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.tbl_contains(keep, vim.bo[buf].filetype) then
              vim.bo[buf].buftype = "" -- set buftype to empty to keep the window
            end
          end
        end,
      })
    end,
  },
}
