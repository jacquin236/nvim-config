return {
  {
    "danymat/neogen",
    cmd = "Neogen",
    -- stylua: ignore
    keys = {
      { "<leader>ad", function() require("neogen").generate() end, desc = "[neogen] default annotation" },
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
        opts.snippet_engin = "nvim"
      end
    end,
  },
}
