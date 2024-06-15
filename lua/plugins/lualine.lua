return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "arkav/lualine-lsp-progress" },
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus
      local colors = require("tokyonight.colors").setup()
      local util = require("tokyonight.util")

      local mode = {
        "mode",
        fmt = function(str)
          return "󰀘 " .. str .. " "
        end,
        color = { gui = "bold" },
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.o.columns > 100
        end,
      }

      local filesize = {
        "filesize",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.orange, gui = "bold" },
        padding = 1,
      }

      local filename = {
        "filename",
        cond = conditions.buffer_not_empty,
        color = { gui = "bold", fg = colors.fg },
        path = 4,
        file_status = true,
        padding = 1,
      }

      local branch = {
        "branch",
        icon = "",
        color = { fg = colors.teal },
      }

      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end

      local diff = {
        "diff",
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
        padding = 1,
        cond = conditions.hide_in_width,
        source = diff_source,
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red },
        },
      }

      local diagnostics = {
        "diagnostics",
        sections = { "error", "warn", "info", "hint" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        colored = true,
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.green },
          hint = { fg = colors.cyan },
        },
        update_in_insert = false,
        always_visible = true,
      }

      local lsp_progress = {
        "lsp_progress",
        display_components = { "lsp_client_name", { "title", "percentage", "message" }, "spinner" },
        colors = {
          percentage = util.lighten(colors.magenta2, 0.7),
          title = colors.magenta,
          message = colors.yellow,
          lsp_client_name = colors.cyan,
          use = true,
        },
        timer = { progress_enddelay = 1000, spinner = 2500, lsp_client_name_enddelay = 2500 },
        spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
      }

      local spaces = {
        function()
          local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
          return "󰌒 " .. "" .. shiftwidth
        end,
        color = { gui = "bold", fg = colors.red },
      }

      local progress = {
        function()
          local current_line = vim.fn.line(".")
          local total_lines = vim.fn.line("$")
          local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
          local line_ratio = current_line / total_lines
          local index = math.ceil(line_ratio * #chars)
          return chars[index]
        end,
      }

      local time = {
        function()
          return " " .. os.date("%R")
        end,
        color = { fg = util.lighten(colors.teal, 0.6) },
      }

      local location = {
        "location",
        color = { fg = colors.green },
      }

      local encoding = {
        "o:encoding",
        fmt = string.upper,
        color = { fg = colors.yellow },
      }

      local debugger = {
        function()
          return "  " .. require("dap").status()
        end,
        cond = function()
          return package.loaded["dap"] and require("dap").status() ~= ""
        end,
        color = function()
          return LazyVim.ui.fg("Debug")
        end,
      }

      local statement = {
        function()
          return require("noice").api.status.command.get()
        end,
        cond = function()
          return package.loaded["noice"] and require("noice").api.status.command.has()
        end,
        color = function()
          return LazyVim.ui.fg("Statement")
        end,
      }

      local constant = {
        function()
          return require("noice").api.status.mode.get()
        end,
        cond = function()
          return package.loaded["noice"] and require("noice").api.status.mode.has()
        end,
        color = function()
          return LazyVim.ui.fg("Constant")
        end,
      }

      local search = {
        function()
          return require("noice").api.status.search.get()
        end,
        cond = function()
          return package.loaded["noice"] and require("noice").api.status.search.has()
        end,
        color = function()
          return LazyVim.ui.fg("DiagnosticOk")
        end,
      }

      local clients = {
        function()
          local num_clients = #vim.lsp.get_clients({ bufnr = 0 })
          if num_clients > 0 then
            return " " .. num_clients
          end
          return ""
        end,
        color = { fg = util.lighten(colors.magenta2, 0.4) },
      }

      local opts = {
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = "",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { diagnostics },
          lualine_c = { branch, filesize, filename },
          lualine_x = { lsp_progress, debugger, diff },
          lualine_y = { constant, search, statement, spaces, encoding, clients, location, time },
          lualine_z = { progress },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy", "quickfix" },
      }

      if vim.g.trouble_lualine then
        local trouble = require("trouble")
        local symbols = trouble.statusline
          and trouble.statusline({
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
          })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = symbols and symbols.has,
        })
      end

      return opts
    end,
  },
}
