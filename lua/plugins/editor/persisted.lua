return {
  {
    "olimorris/persisted.nvim",
    lazy = false,
    opts = {
      autoload = true,
      use_git_branch = true,
      allowed_dirs = {
        vim.g.projects_dir .. "/nvim-projects",
        vim.fn.expand("~/.config"),
      },
      ignored_dirs = { vim.fn.stdpath("data") },
    },
  },
}
