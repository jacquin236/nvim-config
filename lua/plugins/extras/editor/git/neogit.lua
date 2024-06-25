return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      { "sindrets/diffview.nvim", optional = true },
    },
    keys = {
      {
        "<leader>gns",
        function()
          require("neogit").open()
        end,
        desc = "Neogit Open Status Buffer",
      },
      {
        "<leader>gnc",
        function()
          require("neogit").open({ "commit" })
        end,
        desc = "Neogit Open Commit Buffer",
      },
      {
        "<leader>gnl",
        function()
          require("neogit.popups.pull").create()
        end,
        desc = "Neogit Open Pull Popup",
      },
      {
        "<leader>gnp",
        function()
          require("neogit.popups.push").create()
        end,
        desc = "Neogit Open Push Popup",
      },
    },
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
        telescope = true,
        diffview = true,
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>gn"] = { name = "Neogit" },
      },
    },
  },
}
