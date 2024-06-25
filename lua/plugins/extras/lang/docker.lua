return {
  { import = "lazyvim.plugins.extras.lang.docker" },
  {
    "jacquin236/nvim-devdocs",
    optional = true,
    opts = {
      ensure_installed = { "docker" },
    },
  },
}
