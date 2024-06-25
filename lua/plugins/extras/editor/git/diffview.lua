return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gR", "<cmd>DiffviewFileHistory<CR>", desc = "Repo History (Diff)" },
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff View" },
    },
    opts = function(_, opts)
      local actions = require("diffview.actions")

      opts.default_args = { DiffviewFileHistory = { "%" } }
      opts.enhanced_diff_hl = true
      opts.view = {
        default = { winbar_info = true },
        file_history = { winbar_info = true },
      }
      opts.hooks = {
        diff_buf_read = function(bufnr)
          local opt = vim.opt_local
          opt.wrap, opt.list, opt.relativenumber = false, false, false
          opt.colorcolumn = ""
          vim.b[bufnr].view_activated = false
        end,
      }

      opts.keymaps = {
        --stylua: ignore
        view = {
          { "n",                         "<leader>gCo", actions.conflict_choose("ours"),       { desc = "Choose the OURS version of a conflict" } },
          { "n",                         "<leader>gCt", actions.conflict_choose("theirs"),     { desc = "Choose the THEIRS version of a conflict" } },
          { "n",                         "<leader>gCb", actions.conflict_choose("base"),       { desc = "Choose the BASE version of a conflict" } },
          { "n",                         "<leader>gCa", actions.conflict_choose("all"),        { desc = "Choose all the versions of a conflict" } },
          { "n",                         "<leader>gCx", actions.conflict_choose("none"),       { desc = "Delete the conflict region" } },
          { "n",                         "<leader>gCO", actions.conflict_choose_all("ours"),   { desc = "Choose the OURS version of a conflict for the whole file" } },
          { "n",                         "<leader>gCT", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
          { "n",                         "<leader>gCB", actions.conflict_choose_all("base"),   { desc = "Choose the BASE version of a conflict for the whole file" } },
          { "n",                         "<leader>gCA", actions.conflict_choose_all("all"),    { desc = "Choose all the versions of a conflict for the whole file" } },
          { "n",                         "<leader>gCX", actions.conflict_choose_all("none"),   { desc = "Delete the conflict region for the whole file" } },
          { q = "<cmd>DiffviewClose<cr>" },
        },
        --stylua: ignore
        file_panel = {
          { "n",                         "<leader>gCO", actions.conflict_choose_all("ours"),   { desc = "Choose the OURS version of a conflict for the whole file" } },
          { "n",                         "<leader>gCT", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
          { "n",                         "<leader>gCB", actions.conflict_choose_all("base"),   { desc = "Choose the BASE version of a conflict for the whole file" } },
          { "n",                         "<leader>gCA", actions.conflict_choose_all("all"),    { desc = "Choose all the versions of a conflict for the whole file" } },
          { "n",                         "<leader>gCX", actions.conflict_choose_all("none"),   { desc = "Delete the conflict region for the whole file" } },
          { q = "<cmd>DiffviewClose<cr>" },
        },
        file_history_panel = { q = "<cmd>DiffviewClose<cr>" },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>gC"] = { name = "Conflicts" },
      },
    },
  },
}
