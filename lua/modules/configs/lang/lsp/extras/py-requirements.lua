return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "requirements",
      },
    },
  },
  {
    "MeanderingProgrammer/py-requirements.nvim",
    event = {
      "BufRead requirements.txt",
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "hrsh7th/nvim-cmp",
        dependencies = {},
        opts = function(_, opts)
          table.insert(opts.sources, { name = "py-requirements" })
        end,
      },
    },
    opts = {
      enable_cmp = true,
      file_patterns = { "requirements.txt" },
      float_opts = { border = "rounded" },
      filter = { final_release = true },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ppu", function() require("py-requirements").upgrade() end, desc = "[py-requirements] Update Package" },
      { "<leader>ppi", function() require("py-requirements").show_description() end, desc = "[py-requirements] Package Info" },
      { "<leader>ppa", function() require("py-requirements").upgrade_all() end, desc = "[py-requirements] Update All Packages" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>p", group = "packages/dependencies", icon = " ", mode = { "n", "v" } },
        { "<leader>pp", group = "python: requirements", icon = " " },
      },
    },
  },
}
