return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    opts = function(_, opts)
      opts.indent = {
        enable = true,
        disable = {
          "markdown",
          "gitrebase",
          "yaml",
          "typescript",
          "javascript",
        },
      }
      opts.endwise = { enable = true }
      opts.rainbow = { enable = true, query = "rainbow-delimiters" }
      opts.textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
            ["]m"] = "@comment.outer",
            ["]/"] = "@regex.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
            ["]M"] = "@comment.outer",
            ["]\\"] = "@regex.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
            ["[m"] = "@comment.outer",
            ["[/"] = "@regex.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
            ["[M"] = "@comment.outer",
            ["[\\"] = "@regex.outer",
          },
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
            ["aa"] = { query = "@call.outer", desc = "ts: all call" },
            ["ia"] = { query = "@call.inner", desc = "ts: inner call" },
            ["ap"] = { query = "@parameter.outer", desc = "ts: all parameter" },
            ["ip"] = { query = "@parameter.inner", desc = "ts: inner parameter" },
          },
          selection_modes = {
            ["@function.outer"] = "V", -- linewise
          },
        },
        lsp_interop = {
          enable = true,
          floating_preview_opts = {},
        },
      }
      opts.matchup = {
        enable = true,
        include_match_words = true,
        disable = { "python" },
      }
    end,
  },
}
