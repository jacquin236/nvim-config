vim.g.lazydev_enabled = true

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        "lazy.nvim",
        "luvit-meta/library",
        "neotest",
        "plenary",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "luassert-types/library", words = { "assert" } },
        { path = "busted-types/library", words = { "describe" } },
      },
      integrations = {
        lspconfig = true,
        cmp = true,
      },
    },
  },
  { "Bilal2453/luvit-meta" }, -- optional `vim.uv` typings
  { "LuaCATS/luassert", name = "luassert-types" },
  { "LuaCATS/busted", name = "busted-types" },
}
