local api_ui = require("dbee").api.ui
local tools = require("dbee.layouts.tools")
local utils = require("dbee.utils")

---@class Newlayout: Layout
---@field private egg? layout_egg
---@field private windows integer[]
---@field private is_opened boolean
local Newlayout = {}

---Create default layout.
---@return Newlayout
function Newlayout:new()
  ---@type Newlayout
  local o = {
    egg = nil,
    is_opened = false,
    windows = {},
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

---Close dbee when another (inapproriate) buffer is opened in the window
---@package
---@param winid integer
---@param is_editor? boolean Special care needs to be taken with editor - which uses multiple buffers.
function Newlayout:configure_win_close_on_switch(winid, is_editor)
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
    vim.api.nvim_win_set_buf(0, buf)
  end

  utils.create_singleton_autocmd({ "BufWinEnter", "BufReadPost", "BufNewFile" }, {
    window = winid,
    callback = function(event)
      action(winid, event.buf, event.file)
    end,
  })
end

---Cloase all other windows when one is closed.
---@package
---@param winid integer
function Newlayout:configure_win_on_quit(winid)
  utils.create_singleton_autocmd({ "QuitPre" }, {
    window = winid,
    callback = function()
      self:close()
    end,
  })
end

---Dbee popup
---@private
---@param show_fn fun(win_id: integer) Function to open dbee view.
function Newlayout:open_popup(show_fn)
  local ui_spec = vim.api.nvim_list_uis()[1]
  local win_width = 60
  local win_height = 30
  local x = 15
  local y = math.floor((ui_spec["height"] - win_height) / 2)

  -- create new dummy buffer
  local tmp_buf = vim.api.nvim_create_buf(false, true)
  -- open win
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

  -- remove temp buffer
  pcall(vim.api.nvim_buf_delete, tmp_buf, { force = true })

  -- set exit strategies
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
function Newlayout:is_open()
  return self.is_opened
end

---Open drawer popup
function Newlayout:open_drawer()
  self:open_popup(api_ui.drawer_show)
end

---Open call log popup
function Newlayout:open_call_log()
  self:open_popup(api_ui.call_log_show)
end

---Open result and editor views in a split
function Newlayout:open()
  self.egg = tools.save()
  self.windows = {}

  -- editor
  tools.make_only(0)
  local editor_win = vim.api.nvim_get_current_win()
  table.insert(self.windows, editor_win)
  api_ui.editor_show(editor_win)
  self:configure_win_close_on_switch(editor_win, true)
  self:configure_win_on_quit(editor_win)

  -- result
  vim.cmd("bo split")
  local win = vim.api.nvim_get_current_win()
  table.insert(self.windows, win)
  api_ui.result_show(win)
  self:configure_win_close_on_switch(win)
  self.configure_win_on_quit(win)

  -- set cursor to editor
  vim.api.nvim_set_current_win(editor_win)
  self.is_opened = true
end

function Newlayout:close()
  -- close all windows
  for _, win in ipairs(self.windows) do
    pcall(vim.api.nvim_win_close, win, false)
  end

  -- restore layout
  tools.restore(self.egg)
  self.egg = nil
  self.is_opened = false
end

return Newlayout
