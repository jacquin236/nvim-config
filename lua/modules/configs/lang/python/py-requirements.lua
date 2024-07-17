return {
  {
    "MeanderingProgrammer/py-requirements.nvim",
    event = { "BufRead requirements.txt" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          table.insert(opts.sources, { name = "py-requirements" })
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "requirements" } },
      },
    },
    opts = {
      enable_cmp = true,
      file_patterns = { "requirements.txt" },
      float_opts = { border = "rounded" },
      filter = { final_release = true },
    },
    keys = {
      {
        "<leader>ppu",
        function()
          require("py-requirements").upgrade()
        end,
        desc = "[py-requirements] Update Package",
      },
      {
        "<leader>ppi",
        function()
          require("py-requirements").show_description()
        end,
        desc = "[py-requirements] Package Info",
      },
      {
        "<leader>ppA",
        function()
          require("py-requirements").upgrade_all()
        end,
        desc = "[py-requirements] Update All Packages",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>pp", group = "python: requirements", icon = " " },
      },
    },
  },
}
