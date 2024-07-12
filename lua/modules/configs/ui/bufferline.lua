local function is_ft(b, ft)
  return vim.bo[b].filetype == ft
end

local function custom_filter(buf, buf_nums)
  local logs = vim.tbl_filter(function(b)
    return is_ft(b, "log")
  end, buf_nums or {})
  if vim.tbl_isempty(logs) then
    return true
  end
  local tab_num = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr("$")
  local is_log = is_ft(buf, "log")
  if last_tab == 1 then
    return true
  end
  -- only show log buffers in secondary tabs
  return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
end

local icons = {
  ui = require("util.icons").ui,
  divider = require("util.icons").dividers,
}

return {
  {
    "akinsho/bufferline.nvim",
    event = "UIEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      local bufferline = require("bufferline")

      bufferline.setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get({
          styles = { "bold", "italic" },
          custom = {
            all = { fill = { bg = mocha.crust } },
            mocha = { background = { fg = mocha.mauve } },
          },
        }),
        options = {
          themable = true,
          show_duplicate_prefix = true,
          duplicates_across_groups = true,
          sort_by = "id",
          debug = { logging = false },
          max_name_length = 18,
          max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
          truncate_names = true, -- whether or not tab names should be truncated
          tab_size = 18,
          style_preset = { bufferline.style_preset.minimal },
          show_close_icon = false,
          show_buffer_close_icons = true,
          indicator = { style = "underline" },
          diagnostics = false,
          hover = { enabled = true, delay = 100, reveal = { "close" } },
          show_tab_indicators = true,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          -- can also be a table containing 2 custom separators
          -- [focused and unfocused]. eg: { '|', '|' }
          separator_style = "slant",
          enforce_regular_tabs = false,
          numbers = "none",
          buffer_close_icon = icons.ui.Close,
          modified_icon = icons.ui.CircleSmall,
          close_icon = icons.ui.CloseBold,
          left_trunc_marker = icons.divider.ArrowCircleLeft,
          right_trunc_marker = icons.divider.ArrowCircleRight,
          name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
            -- remove extension from markdown files for example
            if buf.name:match("%.md") then
              return vim.fn.fnamemodify(buf.name, ":t:r")
            end
          end,

          color_icons = true,
          always_show_bufferline = false,
          auto_toggle_bufferline = true,
          offsets = {
            {
              text = " EXPLORER",
              filetype = "neo-tree",
              highlight = "Directory",
              text_align = "left",
              separator = true,
              padding = 1,
            },
            {
              text = " UNDOTREE",
              filetype = "undotree",
              highlight = "PanelHeading",
              separator = true,
              padding = 1,
            },
            {
              text = "󰆼 DATABASE VIEWER",
              filetype = "dbui",
              highlight = "PanelHeading",
              separator = true,
              padding = 1,
            },
            {
              text = " DIFF VIEW",
              filetype = "DiffviewFiles",
              highlight = "PanelHeading",
              separator = true,
              padding = 1,
            },
            {
              filetype = "lazy",
              text = "Lazy",
              highlight = "PanelHeading",
              padding = 1,
            },
          },
          groups = {
            options = { toggle_hidden_on_enter = true },
            items = {
              bufferline.groups.builtin.pinned:with({ icon = "" }),
              bufferline.groups.builtin.ungrouped,
              {
                name = "SQL",
                matcher = function(buf)
                  return buf.name:match("%.sql$")
                end,
              },
              {
                name = "tests",
                icon = "",
                matcher = function(buf)
                  local name = buf.name
                  return name:match("[_%.]spec") or name:match("[_%.]test")
                end,
              },
              {
                name = "docs",
                icon = "",
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
            custom_filter = custom_filter,
          },
        },
      })
    end,
  },
}
