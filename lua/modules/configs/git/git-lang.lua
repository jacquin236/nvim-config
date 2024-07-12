vim.filetype.add({
  filename = {
    ["NEOGIT_COMMIT_EDITMSG"] = "NeogitCommitMessage",
  },
})

vim.treesitter.language.register("gitcommit", "NeogitCommitMessage")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "git_config", "gitcommit", "git_rebase", "gitignore", "gitattributes" } },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gh" })
    end,
  },
  {
    "nvim-cmp",
    dependencies = {
      {
        "petertriho/cmp-git",
        opts = { filetypes = { "gitcommit", "NeogitCommitMessage" } },
        config = function(_, opts)
          require("cmp_git").setup(opts)

          local cmp = require("cmp")
          cmp.setup.filetype("NeogitCommitMessage", {
            sources = {
              { name = "git", group_index = 1 },
              { name = "luasnip", group_index = 1 },
              { name = "dictionary", group_index = 1 },
              { name = "spell", group_index = 1 },
              { name = "buffer", group_index = 2 },
            },
          })
        end,
      },
    },
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "git" })
    end,
  },
}
