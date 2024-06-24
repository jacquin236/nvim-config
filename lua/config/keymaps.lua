local map = vim.keymap.set

-- Lazy options
map("n", "<leader>l", "<Nop>")
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "LazyExtras" })
map("n", "<leader>lu", function() lazy.update() end, { desc = "Lazy Update" })
map("n", "<leader>lC", function() lazy.check() end, { desc = "Lazy Check" })
map("n", "<leader>ls", function() lazy.sync() end, { desc = "Lazy Sync" })
map("n", "<leader>lc", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

-- Disable LazyVim bindings
map("n", "<leader>L", "<Nop>")
map("n", "<leader>fT", "<Nop>")

-- Clipboard
map("n", "<C-a>", "gg<S-V>G", { desc = "Select All Text", silent = true, noremap = true })
map("n", "<C-c>", ":%y+<cr>", { desc = "Copy Whole Text", slient = true })
map("i", "<C-v>", '<C-r>"', { desc = "Paste on Insert Mode" })
map("v", "<C-v>", '"_dP', { desc = "Paste Without Overwriting" })
map("n", "<C-z>", "<C-r>", { desc = "Redo" })

-- Delete and change without yanking
map({ "n", "x" }, "<A-d>", '"_d', { desc = "Delete without yanking" })
map({ "n", "x" }, "<A-c>", '"_c', { desc = "Change without yanking" })

-- Dashboard
map("n", "<leader>fd", function()
  if LazyVim.has("alpha-nvim") then
    require("alpha").start(true)
  elseif LazyVim.has("dashboard-nvim") then
    vim.cmd("Dashboard")
  end
end, { desc = "Dashboard" })

-- Spelling
map("n", "<leader>!", "zg", { desc = "Add Word to Dictionary" })
map("n", "<leader>@", "zug", { desc = "Remove Word from Dictionary" })

-- Statusline
map("n", "<leader>uS", function()
  if vim.o.laststatus:get() == 0 then
    vim.o.laststatus = 3
  else
    vim.o.laststatus = 0
  end
end, { desc = "Toggle Statusline" })

-- Tabline
map("n", "<keader>u<tab>", function()
  if vim.o.showtabline:get() == 0 then
    vim.o.showtabline = 2
  else
    vim.o.showtabline = 0
  end
end, { desc = "Toggle Tabline" })

-- Block comment
map("n", "]/", "/\\S\\zs\\s*╭<CR>zt", { desc = "Next Block Comment" })
map("n", "[/", "?\\S\\zs\\s*╭<CR>zt", { desc = "Prev Block Comment" })

-- Buffers
map("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First Buffer" })
map("n", "<leader>ba", "<cmd>blast<cr>", { desc = "Last Buffer" })
map("n", "<leader>b<tab>", "<cmd>tabnew %<cr>", { desc = "Current Buffer in New Tab" })

-- Tab
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>n", "<Cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader><tab><tab>", function()
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
end, { desc = "Tabs" })

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

-- Plugin Info
map("n", "<leader>cif", "<cmd>LazyFormatInfo<cr>", { desc = "Formatting" })
map("n", "<leader>cic", "<cmd>ConformInfo<cr>", { desc = "Conform" })
local linters = function()
  local linters_attached = require("lint").linters_by_ft[vim.bo.filetype]
  local buf_linters = {}

  if not linters_attached then
    LazyVim.warn("No linters attached", { title = "Linter" })
    return
  end

  for _, linter in pairs(linters_attached) do
    table.insert(buf_linters, linter)
  end

  local unique_client_names = table.concat(buf_linters, ", ")
  local linters = string.format("%s", unique_client_names)

  LazyVim.notify(linters, { title = "Linter" })
end
map("n", "<leader>ciL", linters, { desc = "Lint" })
map("n", "<leader>cir", "<cmd>LazyRoot<cr>", { desc = "Root" })

-- Search inside visually highlighted text
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search Inside Visual Selection" })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
map("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = "Search Selected Text", silent = true })
map("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = "Search Selected Text (Backwards)", silent = true })

-- Marks
map("n", "dm", function()
  local cur_line = vim.fn.line(".")
  -- Delete buffer local mark
  for _, mark in ipairs(vim.fn.getmarklist("%")) do
    if mark.pos[2] == cur_line and mark.mark:match("[a-zA-Z]") then
      vim.api.nvim_buf_del_mark(0, string.sub(mark.mark, 2, #mark.mark))
      return
    end
  end
  -- Delete global marks
  local cur_buf = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
  for _, mark in ipairs(vim.fn.getmarklist()) do
    if mark.pos[1] == cur_buf and mark.pos[2] == cur_line and mark.mark:match("[a-zA-Z]") then
      vim.api.nvim_buf_del_mark(0, string.sub(mark.mark, 2, #mark.mark))
      return
    end
  end
end, { noremap = true, desc = "Mark on Current Line" })