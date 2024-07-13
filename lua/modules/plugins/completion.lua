return {
  {
    "garymjr/nvim-snippets",
    enabled = false,
  },
  { "onsails/lspkind.nvim" },
  { import = "modules.configs.completion.treesitter" },
  { import = "modules.configs.completion.cmp" },
  { import = "modules.configs.completion.autopairs" },
  { import = "modules.configs.completion.luasnip" },
  { import = "modules.configs.completion.format" },
  { import = "modules.configs.completion.lint" },
  { import = "modules.configs.completion.snippets" },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.autopairs = { enable = true }
      opts.playground = { persist_queries = true }
      opts.query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      }
      opts.textobjects.lookahead = true
      opts.textobjects.select = {
        enable = true,
        include_surrounding_whitespace = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "ts: all function" },
          ["if"] = { query = "@function.inner", desc = "ts: inner function" },
          ["ac"] = { query = "@class.outer", desc = "ts: all class" },
          ["ic"] = { query = "@class.inner", desc = "ts: inner class" },
          ["aC"] = { query = "@conditional.outer", desc = "ts: all conditional" },
          ["iC"] = { query = "@conditional.inner", desc = "ts: inner conditional" },
          ["aL"] = { query = "@assignment.lhs", desc = "ts: assignment lhs" },
          ["aR"] = { query = "@assignment.rhs", desc = "ts: assignment rhs" },
        },
      }
      opts.matchup = { enable = true, include_match_words = true }
      opts.rainbow = { enable = true, query = "rainbow-delimiters" }
      opts.endwise = { enable = true }
      opts.indent = { enable = true }
    end,
  },
}
