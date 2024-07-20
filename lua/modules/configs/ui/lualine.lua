local colors = require("util.colors")
local icons = require("util.icons")

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%t:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.o.columns > 100
  end,
}

local formatter = function()
  local status, conform = pcall(require, "conform")
  if not status then
    return "Conform not installed"
  end
  local lsp_format = require("conform.lsp_format")
  -- Get formatters for the current buffer
  local formatters = conform.list_formatters_for_buffer()
  if formatters and #formatters > 0 then
    local formatterNames = {}
    for _, formatter in ipairs(formatters) do
      table.insert(formatterNames, formatter)
    end

    return "󰷈 " .. table.concat(formatterNames, " ")
  end

  -- Check if there's an LSP formatter
  local bufnr = vim.api.nvim_get_current_buf()
  local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

  if not vim.tbl_isempty(lsp_clients) then
    return "󰷈 LSP Formatter"
  end

  return ""
end

local lsp = function()
  local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
  local clients = vim.lsp.get_clients()
  local lsp_lists = {}
  local available_servers = {}
  if next(clients) == nil then
    return icons.ui.LspInactive -- No server available
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    local client_name = client.name
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      -- Avoid adding servers that already exists.
      if not lsp_lists[client_name] then
        lsp_lists[client_name] = true
        table.insert(available_servers, client_name)
      end
    end
  end
  return next(available_servers) == nil and icons.ui.LspInactive
    or string.format("%s [%s]", icons.ui.LspActive, table.concat(available_servers, ", "))
end

local linter = function()
  local linters = require("lint").linters_by_ft[vim.bo.filetype]
  if #linters == 0 then
    return ""
  end

  return "󱉶 "
end

local tabwidth = function()
  return icons.ui.Tab .. " " .. vim.api.nvim_get_option_value("tabstop", { scope = "local" })
end

local scrollbar = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.theme = "catppuccin-mocha"
    opts.options.component_separators = ""
    opts.options.section_separators = ""
    opts.options.disabled_filetypes = {
      statusline = { "dashboard", "alpha", "starter" },
      winbar = { "dashboard", "neo-tree", "toggleterm", "Trouble", "noice" },
      dapui_watches = {},
      dapui_stacks = {},
      dapui_breakpoints = {},
      dapui_scopes = {},
      dapui_console = {},
      dap_repl = {},
    }

    opts.sections.lualine_a = { { "mode", icon = icons.ui.Target, color = { gui = "bold" } } }
    opts.sections.lualine_b[1] = {
      "diagnostics",
      sections = { "error", "warn", "info", "hint" },
      colored = true,
      update_in_insert = false,
      always_visible = true,
      symbols = {
        error = icons.diagnostics.Error .. " ",
        warn = icons.diagnostics.Warning .. " ",
        info = icons.diagnostics.Information .. " ",
        hint = icons.diagnostics.Hint .. " ",
      },
      diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.green },
        hint = { fg = colors.oceanblue },
      },
    }

    opts.sections.lualine_c[2] = "" -- No diagnostics since we already have it

    opts.sections.lualine_c[4] = {
      LazyVim.lualine.pretty_path({
        filename_hl = "Bold",
        modified_hl = "MatchParen",
        directory_hl = "Conceal",
      }),
    }

    table.insert(
      opts.sections.lualine_x,
      2,
      { lsp, color = { fg = colors.oceanblue, gui = "bold" }, cond = conditions.hide_in_width }
    )
    table.insert(opts.sections.lualine_x, 2, { formatter, color = { fg = colors.velvet, gui = "italic" } })
    table.insert(opts.sections.lualine_x, 2, linter)
    table.insert(opts.sections.lualine_x, 2, { tabwidth, color = { fg = colors.light_lavender } })
    opts.sections.lualine_y = { "progress", "location" }
    opts.sections.lualine_z = {
      {
        function()
          return " " .. os.date("%I:%M %p")
        end,
        color = { gui = "bold" },
      },
      { scrollbar },
    }
    opts.extensions = { "lazy", "mason", "nvim-dap-ui" }
    opts.winbar = {
      lualine_a = {
        { "filename", separator = { left = "", right = "" }, color = { gui = "bold" } },
        { "%{%v:lua.dropbar.get_dropbar_str()%}", separator = { left = "", right = "" }, color = "nil" },
      },
    }
  end,
}
