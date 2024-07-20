return {
  { "Bilal2453/luvit-meta" }, -- optional `vim.uv` typings
  { "LuaCATS/luassert", name = "luassert-types" },
  { "LuaCATS/busted", name = "busted-types" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = function(_, opts)
      vim.list_extend(opts.library, {
        { path = "luassert-types/library", words = { "assert" } },
        { path = "busted-types/library", words = { "describe" } },
        "neotest",
        "plenary",
      })
      opts.integrations = {
        lspconfig = true,
        cmp = true,
      }
    end,
  },
}
