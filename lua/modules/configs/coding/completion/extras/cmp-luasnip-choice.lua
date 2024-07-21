return {
  {
    "doxnit/cmp-luasnip-choice",
    opts = {
      auto_open = true,
    },
    config = function(_, opts)
      require("cmp_luasnip_choice").setup(opts)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "luasnip_choice" })
    end,
  },
}
