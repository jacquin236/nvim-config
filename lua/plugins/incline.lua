return {
  {
    "b0o/incline.nvim",
    branch = "main",
    event = "BufReadPost",
    opts = {
      window = {
        zindex = 40,
        margin = { horizontal = 0, vertical = 0 },
      },
      hide = { cursorline = true },
      render = function(props)
        local helpers = require("incline.helpers")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.bo[props.buf].modified and "bold, italic" or "bold"

        local function get_git_diff()
          local icons = require("lazyvim.config").icons.git
          icons["changed"] = icons.modified
          local summary = vim.b.minidiff_summary
          summary = summary
              and {
                added = summary.add,
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
          return labels
        end

        local function get_diagnostic_label()
          local icons = require("lazyvim.config").icons.diagnostics
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
          { get_diagnostic_label() },
          { get_git_diff() },
          ft_icon and {
            " " .. ft_icon .. " ",
            guibg = ft_color,
            guifg = helpers.contrast_color(ft_color),
          } or "",
          { " " .. filename, gui = modified },
          { " 󰕮 " .. vim.api.nvim_win_get_number(props.win), group = "lualine_b_visual" },
        }
        return buffer
      end,
    },
  },
}
