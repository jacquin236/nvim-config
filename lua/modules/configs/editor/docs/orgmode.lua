return {
  {
    "nvim-orgmode/orgmode",
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
      mappings = {
        prefix = "<leader>oo",
        global = {
          org_agenda = "<prefix>a",
          org_carture = "<prefix>c",
        },
      },
    },
  },
  {
    "akinsho/org-bullets.nvim",
    opts = {
      symbols = {
        headlines = { "◉", "○", "✸", "✿" },
        list = "•",
        checkboxes = {
          half = { "🌙", "@org.checkbox.halfchecked" },
          done = { "🌕", "@org.keyword.done" },
          todo = { "🟢", "@org.keyword.todo" },
        },
      },
    },
  },
  {
    "chipsenkbeil/org-roam.nvim",
    tag = "0.1.0",
    opts = {},
  },
}
