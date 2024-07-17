vim.g.lazydev_enabled = true

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      runtime = vim.env.VIMRUNTIME,
      library = {
        "lazy.nvim",
        "luvit-meta/library",
        "neotest",
        "plenary",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
      },
      integrations = {
        lspconfig = true,
        cmp = true,
      },
    },
  },
  { "Bilal2453/luvit-meta" }, -- optional `vim.uv` typings
}
