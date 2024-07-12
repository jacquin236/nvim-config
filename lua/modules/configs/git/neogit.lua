return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "sindrets/diffview.nvim", optional = true },
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Neogit" },
  opts = {
    disable_signs = false,
    disable_hint = true,
    disable_commit_confirmation = true,
    disable_builtin_notifications = true,
    disable_insert_on_commit = false,
    signs = {
      section = { "", "󰘕" }, -- "󰁙", "󰁊"
      item = { "▸", "▾" },
      hunk = { "󰐕", "󰍴" },
    },
    integrations = {
      diffview = true,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>gnn", "<cmd>Neogit<cr>", desc = "Neogit: toggle" },
    { "<leader>gns", function() require("neogit").open() end, desc = "Neogit: open status buffer" },
    { "<leader>gnc", function() require("neogit").open({ "commit" }) end, desc = "Neogit: open commit buffer" },
    { "<leader>gnl", function() require("neogit").popups.pull.create() end, desc = "Neogit: open pull popup" },
    { "<leader>gnp", function() require("neogit").popups.push.create() end, desc = "Neogit: open push popup" },
  }
,
}
