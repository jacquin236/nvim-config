local function augroup(name)
  return vim.api.nvim_create_augroup("docs" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

local popup = nil
local bufnr = nil

local function open_index_in_popup()
  if not popup then
    popup = require("nui.popup")({
      bufnr = bufnr,
      size = { width = "80%", height = "90%" },
      position = { col = "50%", row = "50%" },
      enter = true,
      focusable = true,
      relative = "editor",
      border = { style = "rounded" },
      win_options = { winhighlight = "Normal:Normal, FloatBorder:WinSeparator" },
    })
  end
  autocmd("WinEnter", {
    group = augroup("neorg"),
    pattern = "*.norg",
    callback = function()
      if vim.api.nvim_get_current_win() == popup.winid then
        vim.keymap.set({ "n", "i", "v" }, "<C-q>", function()
          vim.cmd.write()
          popup:hide()
        end, { buffer = popup.bufnr, remap = false })
      end
    end,
  })
  autocmd("WinLeave", {
    group = augroup("neorg"),
    callback = function(args)
      if vim.api.nvim_get_current_win() == popup.winid then
        bufnr = args.buf
        popup:hide()
      end
    end,
  })
  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    popup.bufnr = bufnr
  end
  popup:mount()
  popup:show()
  if vim.bo[vim.api.nvim_win_get_buf(popup.winid)].filetype ~= "norg" then
    vim.cmd.edit("index.norg")
  end
end

return open_index_in_popup
