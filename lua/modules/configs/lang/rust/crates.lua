return {
  {
    "Saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = true },
        crates = { enabled = true },
      },
      popup = {
        border = require("util.icons").border.rounded,
        autofocus = true,
        style = "minimal",
      },
    },
    config = function(_, opts)
      require("crates").setup(opts)
    end,
    keys = {
      -- stylua: ignore start
      { "<leader>prR", function() require("crates").reload() end, desc = "Reload" },
      { "<leader>ptC", function() require("crates").toggle() end, desc = "Toggle" },

      { "<leader>pru", function() require("crates").update_crate() end, desc = "Update Crate" },
      { "<leader>pru", mode = "v", function() require("crates").update_crates() end, desc = "Update Crates" },
      { "<leader>pra", function() require("crates").update_all_crates() end, desc = "Update All Crates" },

      { "<leader>prU", function() require("crates").upgrade_crate() end, desc = "Upgrade Crate" },
      { "<leader>prU", mode = "v", function() require("crates").upgrade_crates() end, desc = "Upgrade Crates" },
      { "<leader>prA", function() require("crates").upgrade_all_crates() end, desc = "Upgrade All Crates" },

      { "<leader>prt", function() require("crates").expand_plain_crate_to_inline_table() end, desc = "Extract into Inline Table" },
      { "<leader>prT", function() require("crates").extract_crate_into_table() end, desc = "Extract into Table" },

      { "<leader>prh", function() require("crates").open_homepage() end, desc = "[h]omepage" },
      { "<leader>prr", function() require("crates").open_repository() end, desc = "[r]epo" },
      { "<leader>prd", function() require("crates").open_documentation() end, desc = "[d]ocumentation" },
      { "<leader>prc", function() require("crates").open_crates_io() end, desc = "[c]rates.io" },
      { "<leader>prl", function() require("crates").open_lib_rs() end, desc = "[l]ib.rs" },

      { "<leader>prv", function() require("crates").show_versions_popup() end, desc = "[v]ersions popup" },
      { "<leader>prp", function() require("crates").show_dependencies_popup() end, desc = "de[p]endencies popup" },
      { "<leader>prf", function() require("crates").show_features_popup() end, desc = "[f]eatures popup" },
      { "<leader>prs", function() require("crates").show_crate_popup() end, desc = "crate[s] details popup" },
      -- stylua: ignore end
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "Saecki/crates.nvim" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "crates" })
    end,
  },
}
