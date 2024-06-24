return {
  { import = "lazyvim.plugins.extras.util.project" },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },
      patterns = {
        ".git",
        "package.json",
        "Makefile",
        "=nvim-projects",
        "=projects",
        "=.config",
      },
    },
  },
}
