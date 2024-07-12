local api_ui = require("dbee.api.ui")
local tools = require("dbee.layouts.tools")
local utils = require("dbee.utils")

---@class Layout
---@field private egg? layout_egg
---@field private windows integer[]
---@field private is_opened boolean
local Layout = {}

---@return Layout
function Layout:new()
  ---@type Layout
  local o = {
    egg = nil,
    is_opened = false,
    windows = {},
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

---@package
---@param winid integer
---@param is_editor? boolean special care needs to be taken with editor - it uses multiple buffers.
function Layout:configure_window_close_on_switch(winid, is_editor)
  local action = function(_, buf, file)
    if is_editor then
      local note, _ = api_ui.editor_search_note_with_file(file)
      if note then
        return
      end

      note, _ = api_ui.editor_search_note_with_buf(buf)
      if note then
        return
      end
    end

    self:close()
    vim.api.nvim_win_set_bug(0, buf)
  end

  utils.create_singleton_autocmd({ "BufWinEnter", "BufReadPost", "BufNewFile" }, {
    window = winid,
    callback = function(event)
      action(winid, event.buf, event.file)
    end,
  })
end

---Close all other windows when one is closed.
---@package
---@param winid integer
function Layout:configure_window_on_quit(winid)
  utils.create_singleton_autocmd({ "QuitPre" }, {
    window = winid,
    callback = function()
      self:close()
    end,
  })
end

---Open call dbee popup
---@private
---@param show_fn fun(winid: integer) function to open a dbee view.
function Layout:open_popup(show_fn)
  local ui_spec = vim.api.nvim_list_uis()[1]
  local win_width = 60
  local win_height = 30
  local x = 15
  local y = math.floor((ui_spec["height"] - win_height) / 2)

  local tmp_buf = vim.api.nvim_create_buf(false, true)

  local winid = vim.api.nvim_open_win(tmp_buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = x,
    row = y,
    border = "rounded",
    title = "",
    title_pos = "center",
    style = "minimal",
  })
  table.insert(self.windows, winid)

  show_fn(winid)

  pcall(vim.api.nvim_buf_delete, tmp_buf, { force = true })

  local bufnr = vim.api.nvim_win_get_buf(winid)
  vim.api.nvim_create_autocmd({ "BufLeave" }, {
    buffer = bufnr,
    callback = function()
      pcall(vim.api.nvim_win_close, winid, true)
    end,
  })
  vim.keymap.set("n", "<esc>", function()
    vim.api.nvim_win_close(winid, true)
  end, { silent = true, buffer = bufnr })
end

---@return boolean
function Layout:is_open()
  return self.is_opened
end

---Open drawer popup
function Layout:open_drawer()
  self:open_popup(api_ui.drawer_show)
end

---Open call log setup
function Layout:open_call_log()
  self:open_popup(api_ui.call_log_show)
end

---This function just opens result and editor views in a split.
function Layout:open()
  -- save layout before opening ui
  self.egg = tools.save()

  self.windows = {}

  -- editor
  tools.make_only(0)
  local editor_win = vim.api.nvim_get_current_win()
  table.insert(self.windows, editor_win)
  api_ui.editor_show(editor_win)
  self:configure_window_close_on_switch(editor_win, true)
  self:configure_window_on_quit(editor_win)

  -- result
  vim.cmd("bo split")
  local win = vim.api.nvim_get_current_win()
  table.insert(self.windows, win)
  api_ui.result_show(win)
  self:configure_window_close_on_switch(win)
  self:configure_window_on_quit(win)

  -- set cursor to editor
  vim.api.nvim_set_current_win(editor_win)

  self.is_opened = true
end

function Layout:close()
  -- close all windows
  for _, win in ipairs(self.windows) do
    pcall(vim.api.nvim_win_close, win, false)
  end

  -- restore layout
  tools.restore(self.egg)
  self.egg = nil
  self.is_opened = false
end

return Layout
