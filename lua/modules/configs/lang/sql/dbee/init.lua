return {
  {
    "kndndrj/nvim-dbee",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function()
      require("dbee").install()
    end,
    config = function()
      local Layout = require("modules.configs.lang.sql.dbee.layout")
      local default = require("dbee.config").default

      local sources
      if conns and not vim.tbl_isempty(conns) then
        sources = vim.list_extend({ require("dbee.sources").MemoerySource:new(conns) }, default.sources)
      else
        sources = default.sources
      end

      local layout = Layout:new()
      local drawer_keymap = {
        key = "BC",
        mode = "n",
        action = function()
          layout:open_drawer()
        end,
      }
      local call_log_keymap = {
        key = "BL",
        mode = "n",
        action = function()
          layout:open_call_log()
        end,
      }
      local expand_mappings = function(defaults)
        table.insert(defaults, drawer_keymap)
        table.insert(defaults, call_log_keymap)
        return defaults
      end

      require("dbee").setup({
        sources = sources,
        drawer = {
          disable_help = true,
          mappings = expand_mappings(default.drawer.mappings),
        },
        editor = { mappings = expand_mappings(default.editor.mappings) },
        call_log = { mappings = expand_mappings(default.call_log.mappings) },
        result = { mappings = expand_mappings(default.result.mappings) },
        window_layout = layout,
      })
    end,
    keys = {
      -- stylua: ignore start
      { "<leader>Dbo", function() return require("dbee").open() end, desc = "[dbee] Open" },
      { "<leader>Dbc", function() return require("dbee").close() end, desc = "[dbee] Close" },
      { "<leader>Dbt", function() return require("dbee").toggle() end, desc = "[dbee] Toggle" },
      { "<leader>Dbe", function() return require("dbee").execute() end, desc = "[dbee] Run a query (active connection)" },
      { "<leader>Dbs", function() return require("dbee").store() end, desc = "[dbee] Store current result (file/buffer/yank-register)" },
      -- stylua: ignore end
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "MattiasMTS/cmp-dbee",
      dependencies = { "kndndrj/nvim-dbee" },
      ft = { "sql" },
      opts = {},
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { "cmp-dbee" })
    end,
  },
}
