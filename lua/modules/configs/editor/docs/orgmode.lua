return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, { "org" })
        end,
      },
    },
    ft = { "org" },
    opts = {
      org_agenda_files = { "~/notes/orgfiles/**/*", "~/projects/notes/org/*" },
      org_default_notes_file = "~/notes/orgfiles/refile.org",
      mappings = {},
    },
    config = function(_, opts)
      require("orgmode").setup(opts)
    end,
  },
  {
    "akinsho/org-bullets.nvim",
    opts = {
      symbols = {
        headlines = { "◉", "○", "✸", "✿" },
        list = "•",
        checkboxes = {
          half = { "🌙", "@org.checkbox.halfchecked" },
        },
      },
    },
  },
  {
    "chipsenkbeil/org-roam.nvim",
    tag = "0.1.0",
    opts = {},
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>oa", group = "[orgmode]⭐agenda", icon = " " },
        { "<leader>oc", group = "[orgmode]⭐capture", icon = " " },
      },
    },
  },
}
