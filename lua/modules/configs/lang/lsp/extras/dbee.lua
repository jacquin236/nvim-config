return {
  {
    "kndndrj/nvim-dbee",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function()
      require("dbee").install()
    end,
    cmd = { "Dbee" },
    opts = function()
      local default = require("dbee.config").default
      local new_layout = require("util.dbee-layout"):new()

      local drawer_keymap = {
        key = "BC",
        mode = "n",
        action = function()
          new_layout:open_drawer()
        end,
      }

      local call_log_keymap = {
        keys = "BL",
        mode = "n",
        action = function()
          new_layout:open_call_log()
        end,
      }

      local expand_mappings = function(defaults)
        table.insert(defaults, drawer_keymap)
        table.insert(defaults, call_log_keymap)
        return defaults
      end

      return {
        window_layout = new_layout,
        drawer = {
          disable_help = true,
          mappings = expand_mappings(default.drawer.mappings),
        },
        editor = {
          mappings = expand_mappings(default.editor.mappings),
        },
        call_log = {
          mappings = expand_mappings(default.call_log.mappings),
        },
        result = {
          mappings = expand_mappings(default.result.mappings),
        },
      }
    end,
    config = function(_, opts)
      require("dbee").setup(opts)

      local base = vim.fs.joinpath(vim.fn.stdpath "state", "dbee", "notes")
      local pattern = string.format("%s/.*", base)
      vim.filetype.add({
        extension = {
          sql = function(path, _)
            if path:match(pattern) then
              return "sql.dbee"
            end
            return "sql"
          end,
        },
        pattern = {
          [pattern] = "sql.dbee",
        },
      })
    end,
    -- stylua: ignore
    keys = {
      { "<leader>Dbo", function() require("dbee").open() end, desc = "[dbee] Open" },
      { "<leader>Dbc", function() require("dbee").close() end, desc = "[dbee] Close" },
      { "<leader>Dbb", function() require("dbee").toggle() end,  desc = "[dbee] Toggle" },
      { "<leader>Dbs", function() require("dbee").store("csv", "buffer", { extra_arg = 0 }) end, desc = "[dbee] Save rows as CSV to Current Buffer" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>Db", group = "dbee", icon = "🐝" },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "MattiasMTS/cmp-dbee",
        dependencies = { "kndndrj/nvim-dbee" },
        ft = "sql",
        opts = {},
      },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "cmp-dbee" })
    end,
  },
}
