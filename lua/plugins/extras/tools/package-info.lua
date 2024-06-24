return {
  {
    "vuki656/package-info.nvim",
    event = { "BufRead package.json", "BufRead package-lock.json" },
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    keys = {
      { "<leader>pwv", function() require('package-info').show({ force = true }) end, desc = "Show Package Versions" },
      { "<leader>pwu", function() require('package-info').update() end,               desc = "Update Package" },
      { "<leader>pwr", function() require('package-info').delete() end,               desc = "Remove Package" },
      { "<leader>pwc", function() require('package-info').change_version() end,       desc = "Change Package Version" },
      { "<leader>pwi", function() require('package-info').install() end,              desc = "Install New Dependency" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>p"] = { name = "  Packages/Dependencies" },
        ["<leader>pw"] = { name = "Web" },
      },
    },
  },
}
