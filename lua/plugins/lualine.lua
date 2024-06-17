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

      local ui = require("util.ui")
      local icons = ui.icons
      local colors = require("util.colors").colors

      local mode = {
        "mode",
        icon = icons.ui.Target,
        color = { gui = "bold" },
        separator = { left = icons.separators.BubbleRight },
        right_padding = 1,
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
        color = { fg = colors.pumpkin, gui = "bold" },
        padding = 1,
      }

      local filename = {
        "filename",
        cond = conditions.buffer_not_empty,
        color = { gui = "bold", fg = colors.white },
        path = 4,
        file_status = true,
        padding = 1,
      }

      local branch = {
        "branch",
        icon = "",
        color = { fg = colors.green },
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
        symbols = {
          added = icons.git.Added .. " ",
          modified = icons.git.Modified .. " ",
          removed = icons.git.Removed .. " ",
        },
        padding = 1,
        cond = conditions.hide_in_width,
        source = diff_source,
        diff_color = {
          added = { fg = colors.cyan },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red },
        },
        separator = { left = icons.separators.RightThinBlock, right = icons.separators.LeftThinBlock },
      }

      local diagnostics = {
        "diagnostics",
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = icons.diagnostics.BoldError .. " ",
          warn = icons.diagnostics.BoldWarning .. " ",
          info = icons.diagnostics.BoldInformation .. " ",
          hint = icons.diagnostics.BoldHint .. " ",
        },
        colored = true,
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.green },
          hint = { fg = colors.oceanblue },
        },
        update_in_insert = false,
        always_visible = true,
      }

      local lsp_progress = {
        "lsp_progress",
        display_components = { "lsp_client_name", "percentage", "spinner" },
        colors = {
          percentage = colors.nectar,
          message = colors.yellow,
          lsp_client_name = colors.cyan,
          use = true,
        },
        display_components = { "lsp_client_name", "percentage", "spinner" },
        timer = { progress_enddelay = 0, spinner = 3000, lsp_client_name_enddelay = 2500 },
        spinner_symbols = require("util.spinners").moon,
      }

      local spaces = {
        function()
          local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
          return icons.ui.Tab .. " " .. shiftwidth
        end,
        color = { gui = "bold", fg = colors.butter },
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
        separator = { right = icons.separators.BubbleLeft },
        left_padding = 1,
      }

      local time = {
        function()
          return icons.misc.Clock .. " " .. os.date("%R")
        end,
        color = { fg = colors.skyblue },
      }

      local location = {
        "location",
        color = { fg = colors.green },
        separator = {
          right = icons.separators.RightThinBlock,
          left = icons.separators.LeftThinBlock,
        },
        padding = 1,
      }

      local encoding = {
        "o:encoding",
        fmt = string.upper,
        color = { fg = colors.evergreen },
      }

      local debugger = {
        function()
          return icons.diagnostics.Debug .. " " .. require("dap").status()
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
        color = { fg = colors.fg },
      }

      local formatter = {
        function()
          local status, conform = pcall(require, "conform")
          if not status then
            return "Conform not installed"
          end
          local lsp_format = require("conform.lsp_format")
          local formatters = conform.list_formatters_for_buffer()
          if formatters and #formatters > 0 then
            local formatterNames = {}
            for _, formatter in ipairs(formatters) do
              table.insert(formatterNames, formatter)
            end
            return "󰷈 " .. table.concat(formatterNames, " ")
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })
          if not vim.tbl_isempty(lsp_clients) then
            return " 󰷈 LSP Formatter "
          end
          return ""
        end,
        color = { gui = "italic", fg = colors.velvet },
        padding = 1,
      }

      local opts = {
        options = {
          theme = "auto",
          icons_enabled = true,
          component_separators = "",
          section_separators = "",
          globalstatus = vim.o.laststatus == 3,
          always_divide_middle = false,
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter" },
            winbar = { "dashboard", "alpha", "starter" },
          },
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { diagnostics },
          lualine_c = { branch, filesize, filename, constant, clients },
          lualine_x = { lsp_progress, search, statement, debugger, diff, encoding, spaces, formatter },
          lualine_y = { location, time },
          lualine_z = { progress },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { filename },
          lualine_x = { location },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy", "quickfix", "toggleterm" },
        winbar = {
          lualine_a = {
            { "filename", separator = { left = "", right = "" } },
            { "%{%v:lua.dropbar.get_dropbar_str()%}", separator = { left = "", right = "" }, color = "nil" },
          },
        },
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
