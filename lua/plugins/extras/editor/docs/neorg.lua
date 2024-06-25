return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    dependencies = {
      "vhyrro/luarocks.nvim",
      "nvim-lua/plenary.nvim",
    },
    ft = "norg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.journal"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/projects/neorg/",
              },
            },
          },
        },
      })
    end,
  },
}
