return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gs', function() require("neogit").open() end,               desc = 'Open Status Buffer' },
      { '<leader>gc', function() require("neogit").open({ 'commit' }) end,   desc = 'Open Commit Buffer' },
      { '<leader>gl', function() require("neogit").popups.pull.create() end, desc = 'Open Pull Popup' },
      { '<leader>gp', function() require("neogit").popups.push.create() end, desc = 'Open Push Popup' },
    },
    opts = {
      disable_signs = false,
      disable_hint = true,
      disable_commit_confirmation = true,
      disable_builtin_notifications = true,
      disable_insert_on_commit = false,
      signs = {
        section = { '', '󰘕' }, -- "󰁙", "󰁊"
        item = { '▸', '▾' },
        hunk = { '󰐕', '󰍴' },
      },
      integrations = {
        diffview = true,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diffview: Open",         mode = "n" },
      { 'gh',         [[:'<'>DiffviewFileHistory<cr>]], desc = 'Diffview: File History', mode = 'v' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>',   desc = 'Diffview: File History', mode = 'n' },
    },
    opts = {
      default_args = { DiffviewFileHistory = { "%" } },
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function()
          local opt = vim.opt_local
          opt.wrap, opt.list, opt.relativenumber = false, false, false
          opt.colorcolumn = ""
        end,
      },
      keymaps = {
        view = { q = '<cmd>DiffviewClose<cr>' },
        file_panel = { q = '<cmd>DiffviewClose<cr>' },
        file_history_panel = { q = '<cmd>DiffviewClose<cr>' },
      },
    },
    config = function(_, opts)
      require('diffview').setup(opts)
    end,
  },
}
