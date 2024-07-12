vim.g.lazydev_enabled = true

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      runtime = vim.env.VIMRUNTIME,
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        "lazy.nvim",
      },
      integrations = {
        lspconfig = true,
        cmp = true,
      },
    },
  },
  { "Bilal2453/luvit-meta" }, -- optional `vim.uv` typings
}
