return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.endwise = { enable = true }
      opts.rainbow = { enable = true }
      opts.textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
        lookahead = true,
        select = {
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
        },
      }
      opts.matchup = { enable = true, include_match_words = true }
    end,
  },
}
