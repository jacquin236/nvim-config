return {
  {
    "kndndrj/nvim-dbee",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function()
      require("dbee").install()
    end,
    opts = function()
      local new_layout = require("util.dbee-layout"):new()
      return {
        window_layout = new_layout,
        float_options = {
          winblend = 0,
        },
        sources = {
          require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
          require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
        },
        drawer = {
          mappings = {
            {
              key = "BC",
              mode = "n",
              action = function()
                new_layout:open_drawer()
              end,
            },
          },
        },
        call_log = {
          mappings = {
            {
              key = "BL",
              mode = "n",
              action = function()
                new_layout:open_call_log()
              end,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("dbee").setup(opts)
    end,
  },
}
