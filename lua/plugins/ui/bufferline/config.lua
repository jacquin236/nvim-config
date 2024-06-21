local colors = require("util.colors")
local icons = require("util.icons")
local filter = require("plugins.ui.bufferline.filter")

local groups = {
  options = { toggle_hidden_on_enter = true },
  items = {
    require("bufferline").groups.builtin.pinned:with({ icon = icons.misc.Pin }),
    require("bufferline").groups.builtin.ungrouped,
    {
      name = "Dependencies",
      icon = icons.misc.GearAlt,
      highlight = { fg = colors.nectar },
      matcher = function(buf)
        return vim.startswith(buf.path, vim.env.VIMRUNTIME)
      end,
    },
    {
      name = "SQL",
      matcher = function(buf)
        return buf.name:match("%.sql$")
      end,
    },
    {
      name = "Tests",
      icon = icons.misc.Test,
      matcher = function(buf)
        return buf.name:match("[_%.]spec") or buf.name:match("[_%.]test")
      end,
    },
    {
      name = "Docs",
      icon = icons.misc.Docs,
      matcher = function(buf)
        if vim.bo[buf.id].filetype == "man" or buf.path:match("man://") then
          return true
        end
        for _, ext in ipairs({ "md", "txt", "org", "norg", "wiki" }) do
          if ext == vim.fn.fnamemodify(buf.path, ":e") then
            return true
          end
        end
      end,
    },
  },
}

local offsets = {
  {
    filetype = "neo-tree",
    text = " EXPLORER",
    highlight = "Directory",
    text_align = "left",
    padding = 1,
  },
  {
    filetype = "undotree",
    text = " UNDOTREE",
    highlight = "PanelHeading",
    padding = 1,
  },
  {
    text = "󰆼 DATABASE VIEWER",
    filetype = "dbui",
    highlight = "PanelHeading",
    separator = true,
  },
  {
    filetype = "DiffviewFiles",
    text = " DIFF VIEW",
    highlight = "PanelHeading",
    padding = 1,
  },
  {
    filetype = "lazy",
    text = " LAZY",
    highlight = "PanelHeading",
    padding = 1,
  },
}

local highlights = {
  background = { italic = true },
  buffer_selected = { bold = true },
  fill = { bg = colors.darkpurple },
  separator = { fg = colors.darkpurple },
  separator_selected = { fg = colors.darkpurple },
  separator_visible = { fg = colors.darkpurple },
  close_button_selected = { fg = colors.blue },
  indicator_selected = { fg = colors.pumpkin },
}

local options = {
  themable = true,
  close_command = function(n)
    LazyVim.ui.bufremove(n)
  end,
  right_mouse_command = function(n)
    LazyVim.ui.bufremove(n)
  end,
  left_mouse_command = "buffer %d",
  diagnostics = false,
  mode = "buffers",
  numbers = "none",
  buffer_close_icon = icons.ui.Close,
  modified_icon = icons.ui.SmallCircle,
  close_icon = icons.ui.BoldClose,
  left_trunc_marker = icons.ui.ArrowCircleLeft,
  right_trunc_marker = icons.ui.ArrowCircleRight,
  color_icons = true,
  get_element_icon = function(opts)
    return LazyVim.config.icons.ft[opts.filetype]
  end,
  show_buffer_icons = true,
  show_buffer_close_icons = true,
  show_close_icon = false,
  show_tab_indicators = true,
  enforce_regular_tabs = false,
  persist_buffer_sort = true,
  separator_style = "slant",
  indicator = { style = "underline" },
  style_preset = { require("bufferline").style_preset.minimal },
  always_show_bufferline = false,
  auto_toggle_bufferline = true,
  hover = { enabled = true, delay = 100, reveal = { "close" } },
  sort_by = "id",
  debug = { logging = false },
  max_name_length = 18,
  max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
  truncate_names = true,  -- whether or not tab names should be truncated
  tab_size = 18,
  custom_filter = filter.custom_filter,
  groups = groups,
  offsets = offsets,
}

return {
  highlights = highlights,
  options = options,
}
