local map = vim.keymap.set

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Number: Toggle Line Number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Number: Toggle Relative Number" })

map("n", "<leader><TAB>n", "<Cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader><TAB><TAB>", function()
  vim.ui.select(vim.api.nvim_list_tabpages(), {
    prompt = "Select Tab:",
    format_item = function(tabid)
      local wins = vim.api.nvim_tabpage_list_wins(tabid)
      local not_floating_win = function(winid)
        return vim.api.nvim_win_get_config(winid).relative == ""
      end
      wins = vim.tbl_filter(not_floating_win, wins)
      local bufs = {}
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
        if buftype ~= "nofile" then
          local fname = vim.api.nvim_buf_get_name(buf)
          table.insert(bufs, vim.fn.fnamemodify(fname, ":t"))
        end
      end
      local tabnr = vim.api.nvim_tabpage_get_number(tabid)
      local cwd = string.format(" %8s: ", vim.fn.fnamemodify(vim.fn.getcwd(-1, tabnr), ":t"))
      local is_current = vim.api.nvim_tabpage_get_number(0) == tabnr and "✸" or " "
      return tabnr .. is_current .. cwd .. table.concat(bufs, ", ")
    end,
  }, function(tabid)
    if tabid ~= nil then
      vim.cmd(tabid .. "tabnext")
    end
  end)
end, { desc = "Select Tab" })

-- WinShift
map({ "n", "t" }, "<A-h>", require("smart-splits").resize_left, { desc = "SmartSplits: Resize Left" })
map({ "n", "t" }, "<A-j>", require("smart-splits").resize_down, { desc = "SmartSplits: Resize Down" })
map({ "n", "t" }, "<A-k>", require("smart-splits").resize_up, { desc = "SmartSplits Resize Up" })
map({ "n", "t" }, "<A-l>", require("smart-splits").resize_right, { desc = "SmartSplits: Resize Right" })
map({ "n", "t" }, "<C-h>", require("smart-splits").move_cursor_left, { desc = "SmartSplits: Move Cursor Left" })
map({ "n", "t" }, "<C-j>", require("smart-splits").move_cursor_down, { desc = "SmartSplits: Move Cursor Down" })
map({ "n", "t" }, "<C-k>", require("smart-splits").move_cursor_up, { desc = "SmartSplits: Move Cursor Up" })
map({ "n", "t" }, "<C-l>", require("smart-splits").move_cursor_right, { desc = "SmartSplits: Move Cursor Right" })
map(
  { "n", "t" },
  "<C-\\>",
  require("smart-splits").move_cursor_previous,
  { desc = "SmartSplits: Move Cursor Previous" }
)
map("n", "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "SmartSplits: Swap Buffers Left" })
map("n", "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "SmartSplits: Swap Buffers Down" })
map("n", "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "SmartSplits: Swap Buffers Up" })
map("n", "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "SmartSplits: Swap Buffers Right" })
