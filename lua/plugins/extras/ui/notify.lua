local icons = require("util.icons")

return {
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
      timeout = 3000,
      fps = 20,
      top_down = true,
      background_colour = "NormalFloat",
      render = "default",
      minimum_width = 50,
      icons = {
        ERROR = icons.diagnostics.Error,
        WARN = icons.diagnostics.Warning,
        INFO = icons.diagnostics.Information,
        DEBUG = icons.diagnostics.Debug,
        TRACE = icons.diagnostics.Trace,
      },
      max_width = function()
        return math.floor(vim.o.columns * 0.6)
      end,
      max_height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
      on_open = function(win)
        if not vim.api.nvim_win_is_valid(win) then
          return
        end
        vim.api.nvim_set_option_value("winblend", 0, { scope = "local", win = win })
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    config = function(_, opts)
      local notify = require("notify")

      notify.setup(opts)

      local colors = require("tokyonight.colors").setup()
      local util = require("tokyonight.util")
      vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = util.darken(colors.red, 0.5) })
      vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = util.darken(colors.yellow, 0.5) })
      vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = util.darken(colors.green, 0.5) })
      vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = util.darken(colors.magenta, 0.5) })
      vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = util.darken(colors.cyan, 0.5) })
      vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = colors.red })
      vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = colors.yellow })
      vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = colors.green })
      vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = colors.magenta })
      vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = colors.cyan })
      vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = util.lighten(colors.red, 0.6) })
      vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = util.lighten(colors.yellow, 0.6) })
      vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = util.lighten(colors.green, 0.6) })
      vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = util.lighten(colors.magenta2, 0.6) })
      vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = util.lighten(colors.cyan, 0.6) })

      vim.notify = notify
    end,
  },
}
