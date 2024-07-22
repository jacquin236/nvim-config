return {
  {
    "LintaoAmons/cd-project.nvim",
    cmd = {
      "CdProject",
      "CdProjectTab",
      "CdProjectAdd",
      "CdProjectBack",
      "CdProjectManualAdd",
      "CdSearchAndAdd",
    },
    opts = {
      projects_config_filslepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/projects.json"),
      projects_picker = "telescope",
      projects_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
      auto_register_project = false,
      choice_format = "name",
    },
    config = function(_, opts)
      require("cd-project").setup(opts)
    end,
    keys = {
      { "<leader>Pp", "<cmd>CdProject<cr>", desc = "Change Working Dir" },
      { "<leader>Pt", "<cmd>CdProjectTab<cr>", desc = "Change Working Dir (tab)" },
      { "<leader>Pa", "<cmd>CdProjectAdd<cr>", desc = "Add Current Dir (json file)" },
      { "<leader>Pb", "<cmd>CdProjectBack<cr>", desc = "Switch Current & Previous Project" },
      { "<leader>PA", "<cmd>CdProjectManualAdd<cr>", desc = "Add Path (manually) and/or Give Name" },
      { "<leader>Ps", "<cmd>CdSearchAndAdd<Cr>", desc = "Fuzzy Find Dirs (home) and/or Give Name" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>P", group = "projects", icon = " " },
      },
    },
  },
}
