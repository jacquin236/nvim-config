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
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = {
      -- stylua: ignore start
      { "<leader>a", "", desc = " Annotation/Snippets" },
      { "<leader>ad", function() require("neogen").generate() end, desc = "Default Annotation" },
      { "<leader>aC", function() require("neogen").generate({ type = "class" }) end, desc = "Class" },
      { "<leader>af", function() require("neogen").generate({ type = "func" }) end, desc = "Function" },
      { "<leader>at", function() require("neogen").generate({ type = "type" }) end, desc = "Type" },
      { "<leader>aF", function() require("neogen").generate({ type = "file" }) end, desc = "File" },
      -- stylua: ignore end
    },
  },
  {
    "Zeioth/dooku.nvim",
    cmd = { "DookuGenerate", "DookuOpen", "DookuAutoSetup" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ag", "<Cmd>DookuGenerate<cr>", desc = "Generate HTML Docs" },
      { "<leader>ao", "<Cmd>DookuOpen<cr>", desc = "Open HTML Docs" },
    },
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "rcarriga/nvim-notify" },
    keys = {
      -- stylua: ignore start
      { "<leader>aS", function() require("scissors").editSnippet() end, desc = "Edit Snippets" },
      { "<leader>as", mode = { "n", "v" }, function() require("scissors").addNewSnippet() end, desc = "Add Snippets" },
      -- stylua: ignore end
    },
  },
  {
    "smoka7/multicursors.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "smoka7/hydra.nvim" },
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      -- stylua: ignore
      { mode = { "v", "n" }, "<leader>M", "<cmd>MCstart<cr>", desc = "Multicursor" },
    },
    opts = {
      hint_config = { border = require("util.icons").border.rounded, position = "bottom-right" },
      generate_hints = {
        normal = true,
        insert = true,
        extend = true,
        config = { column_count = 1 },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = function(_, opts)
      -- @see: https://github.com/nvim-orgmode/orgmode/issues/481
      local ok, orgmode = pcall(require, "orgmode")
      if ok then
        orgmode.setup_ts_grammar()
      end

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
