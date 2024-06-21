return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    opts = {
      hide = { cursorline = true },
      window = {
        zindex = 40,
        margin = { horizontal = 0, vertical = 0 },
        padding = 0,
        winhighlight = {
          active = { Normal = "Normal" },
          inactive = { Normal = "Normal" },
        },
      },
      render = function(props)
        local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"
        local helpers = require("incline.helpers")

        local function get_filename()
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[UNTITLED]"
          end
          ---@diagnostic disable: no-unknown
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          return {
            ft_icon and { " " .. ft_icon .. " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename .. " ", gui = modified },
          }
        end

        local function get_git_diff()
          if not package.loaded["gitsigns"] then
            return
          end
          local icons = {
            added = require("util.icons").git.Added .. " ",
            changed = require("util.icons").git.Modified .. " ",
            removed = require("util.icons").git.Removed .. " ",
          }
          icons["changed"] = icons.modified
          local summary = vim.b.minidiff_summary
          ---@diagnostic disable: no-unknown
          summary = summary
              and {
                added = summary.added,
                modified = summary.change,
                removed = summary.delete,
              }
            or vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if summary == nil then
            return labels
          end
          for name, icon in pairs(icons) do
            if tonumber(summary[name]) and summary[name] > 0 then
              table.insert(labels, { icon .. summary[name] .. " ", group = "Diff" .. name })
            end
          end
          if #labels > 0 then
            table.insert(labels, { "┊ " })
          end
          return labels
        end

        local function get_diagnostics()
          local icons = {
            error = require("util.icons").diagnostics.Error .. " ",
            warn = require("util.icons").diagnostics.Warning .. " ",
            info = require("util.icons").diagnostics.Information .. " ",
            hint = require("util.icons").diagnostics.Hint .. " ",
          }
          local label = {}
          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { "┊ " })
          end
          return label
        end

        local buffer = {
          { get_diagnostics() },
          { get_git_diff() },
          { get_filename() },
          { "┊ 󰕮 " .. vim.api.nvim_win_get_number(props.win) .. " ", group = "lualine_b_visual" },
          group = props.focused and "ColorColumn" or "SignColumn",
        }
        return buffer
      end,
    },
    config = function(_, opts)
      require("incline").setup(opts)
    end,
  },
}
