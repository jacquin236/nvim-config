local icons = require("util.ui").icons
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
  icon = icons.git.Branch,
  color = { fg = colors.green },
}

local diff = {
  "diff",
  source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,
  symbols = {
    added = icons.git.Added .. " ",
    modified = icons.git.Modified .. " ",
    removed = icons.git.Removed .. " ",
  },
  cond = conditions.hide_in_width,
  padding = 1,
  diff_color = {
    added = { fg = colors.cyan },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
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
  ---@diagnostic disable-next-line: duplicate-index
  display_components = { "lsp_client_name", "percentage", "spinner" },
  colors = {
    percentage = colors.nectar,
    lsp_client_name = colors.yellow,
    use = true,
  },
  ---@diagnostic disable-next-line: duplicate-index
  display_components = { "lsp_client_name", "percentage", "spinner" },
  timer = { progress_enddelay = 0, spinner = 3000, lsp_client_name_enddelay = 2500 },
  spinner_symbols = require("util.spinners").moon,
}

local spaces = {
  function()
    local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
    return icons.ui.Tab .. " " .. shiftwidth
  end,
  color = { fg = colors.butter },
}

local progress = {
  function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.cell(line_ratio * #chars)
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

local formatter = {
  function()
    local status, conform = pcall(require, "conform")
    if not status then
      return "Conform not installed."
    end
    local lsp_format = require("conform.lsp_format")
    local formatters = conform.list_formatters_for_buffer()
    if formatters and #formatters > 0 then
      local formatterNames = {}
      for _, formatter in ipairs(formatters) do
        table.insert(formatterNames, formatter)
      end
      return icons.misc.Pencil .. " " .. table.concat(formatterNames, " ")
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })
    if not vim.tbl_isempty(lsp_clients) then
      return icons.misc.Pencil .. " LSP Formatter "
    end
    return ""
  end,
  color = { gui = "italic", fg = colors.velvet },
  padding = 1,
}

local git_dir = {
  function()
    local git_directory = require("lualine.components.branch.git_branch").find_git_dir()
    if git_directory then
      local path_elements = vim.split(git_directory, "/")
      return path_elements[#path_elements - 1]
    end
    return ""
  end,
  padding = 1,
}

return {
  mode = mode,
  diagnostics = diagnostics,
  branch = branch,
  filesize = filesize,
  filename = filename,
  constant = constant,
  lsp_progress = lsp_progress,
  search = search,
  statement = statement,
  debugger = debugger,
  diff = diff,
  encoding = encoding,
  spaces = spaces,
  formatter = formatter,
  location = location,
  time = time,
  progress = progress,
  git_dir = git_dir,
}
