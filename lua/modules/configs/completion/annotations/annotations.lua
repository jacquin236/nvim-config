return {
  {
    "danymat/neogen",
    cmd = "Neogen",
    -- stylua: ignore
    keys = {
      { "<leader>an", function() require("neogen").generate() end, desc = "[neogen] default annotations" },
      { "<leader>aC", function() require("neogen").generate({ type = "class" }) end, desc = "[neogen] class" },
      { "<leader>af", function() require("neogen").generate({ type = "func" }) end, desc = "[neogen] function" },
      { "<leader>at", function() require("neogen").generate({ type = "type" }) end, desc = "[neogen] type" },
      { "<leader>aF", function() require("neogen").generate({ type = "file" }) end, desc = "[neogen] file" },
    },
    opts = function(_, opts)
      if opts.snippet_engine ~= nil then
        return
      end
      local map = {
        ["LuaSnip"] = "luasnip",
        ["nvim-snippy"] = "snippy",
        ["vim-vsnip"] = "vsnip",
      }

      for plugin, engine in pairs(map) do
        if LazyVim.has(plugin) then
          opts.snippet_engine = engine
          return
        end
      end

      if vim.snippet then
        opts.snippet_engine = "nvim"
      end
    end,
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = { "rcarriga/nvim-notify" },
    -- stylua: ignore
    keys = {
      { "<leader>ae", function() require("scissors").editSnippet() end, desc = "[scissors] edit snippets" },
      { "<leader>aa", function() require("scissors").addnewSnippet() end, desc = "[scissors] add snippets" },
    },
  },
  {
    "Zeioth/dooku.nvim",
    cmd = { "DookuGenerate", "DookuOpen", "DookuAutoSetup" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ag", "<cmd>DookuGenerate<cr>", desc = "[dooku] generate HTML docs" },
      { "<leader>ao", "<cmd>DookuOpen<cr>", desc = "[dooku] open HTML docs" },
    },
  },
  {
    "LudoPinelli/comment-box.nvim",
    opts = {
      comment_style = "auto",
    },
    keys = {
      { "<leader>acb", "<cmd>CBccbox<cr>", desc = "[comment-box] box title" },
      { "<leader>acc", "<cmd>CBcatalog<cr>", desc = "[comment-box] catalog" },
      { "<leader>acl", "<cmd>CBline<cr>", desc = "[comment-box] simple line" },
      { "<leader>act", "<cmd>CBllline<cr>", desc = "[comment-box] titled line" },
      { "<leader>acm", "<cmd>CBllbox14<cr>", desc = "[comment-box] marked" },
      { "<leader>acd", "<cmd>CBd<cr>", desc = "[comment-box] delete comment style" },
    },
  },
}
