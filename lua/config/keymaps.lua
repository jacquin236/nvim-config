-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local map_del = vim.keymap.del

local lazy = require("lazy")

------------------------------------------ LazyVim ------------------------------------------
map_del("n", "<leader>l")
map_del("n", "<leader>L")

-- stylua: ignore start
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })
map("n", "<leader>lr", "<cmd>LazyRoot<cr>", { desc = "Lazy Root" })
map("n", "<leader>lc", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })
map("n", "<leader>ld", function() vim.fn.system({ "xdg-open", "https://lazyvim.org" }) end, { desc = "LazyVim Docs" })
map("n", "<leader>lR", function() vim.fn.system({ "xdg-open", "https://github.com/LazyVim/LazyVim" }) end, { desc = "LazyVim Repo" })
map("n", "<leader>lu", function() lazy.update() end, { desc = "Lazy Update" })
map("n", "<leader>lC", function() lazy.check() end, { desc = "Lazy Check" })
map("n", "<leader>ls", function() lazy.sync() end, { desc = "Lazy Sync" })
-- stylua: ignore end

--------------------------------------------- LazyGit ------------------------------------------
map_del("n", "<leader>gg")
map_del("n", "<leader>gG")
map_del("n", "<leader>gb")
map_del("n", "<leader>gB")
map_del("n", "<leader>gf")
map_del("n", "<leader>gl")
map_del("n", "<leader>gL")

map("n", "<leader>glg", function()
  LazyVim.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>glG", function()
  LazyVim.lazygit()
end, { desc = "Lazygit (cwd)" })
map("n", "<leader>glb", LazyVim.lazygit.blame_line, { desc = "Lazygit Blame Line" })
map("n", "<leader>glB", LazyVim.lazygit.browse, { desc = "Lazygit Browse" })

map("n", "<leader>glf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  LazyVim.lazygit({ args = { "-f", vim.trim(git_path) } })
end, { desc = "Lazygit Current File History" })

map("n", "<leader>gll", function()
  LazyVim.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
end, { desc = "Lazygit Log" })
map("n", "<leader>glL", function()
  LazyVim.lazygit({ args = { "log" } })
end, { desc = "Lazygit Log (cwd)" })

------------------------------------------ Plugin Info ------------------------------------------
map("n", "<leader>if", "<cmd>LazyFormatInfo<cr>", { desc = "Format" })
map("n", "<leader>ic", "<cmd>ConformInfo<cr>", { desc = "Conform" })
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
map("n", "<leader>iL", linters, { desc = "Lint" })
map("n", "<leader>ir", "<cmd>LazyRoot<cr>", { desc = "Root" })

------------------------------------------ Editing ----------------------------------------------
-- Select
map({ "n", "i" }, "<C-a>", "gg<S-V>G", { desc = "Select All Text", silent = true, noremap = true })
-- Paste
map("i", "<C-v>", '<C-r>"', { desc = "Paste on Insert Mode", silent = true })
-- Copy
map({ "n", "x" }, "<C-c>", ":%y+<cr>", { desc = "Copy Whole Text to Clipboard", silent = true })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
map("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = "Search Selected Text", silent = true })
map("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = "Search Selected Text (Backwards)", silent = true })

-- Move to beginning/end of line
map("n", "<a-h>", "_", { desc = "First Character of Line" })
map("n", "<a-l>", "$", { desc = "Last Character of Line" })

-- Save without formatting
map("n", "<a-s>", "<cmd>noautocmd w<CR>", { desc = "Save Without Formatting" })

-- Spelling
map("n", "<leader>!", "zg", { desc = "Add Word to Dictionary" })
map("n", "<leader>@", "zug", { desc = "Remove Word from Dictionary" })

-- map ]o [o to go to next block comment
map("n", "]o", "/\\S\\zs\\s*╭<CR>zt", { desc = "Next Block Comment" })
map("n", "[o", "?\\S\\zs\\s*╭<CR>zt", { desc = "Prev Block Comment" })

------------------------------------------ Dashboard -------------------------------------------
-- Navigate to Dashboard
-- Dashboard
map("n", "<leader>fd", function()
  if LazyVim.has("alpha-nvim") then
    require("alpha").start(true)
  elseif LazyVim.has("dashboard-nvim") then
    vim.cmd("Dashboard")
  end
end, { desc = "Dashboard" })

--------------------------------------------- Tab ---------------------------------------------
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<s-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
for i = 1, 5 do
  map("n", "<leader><tab>" .. i, "<cmd>tabn " .. i .. "<cr>", { desc = "Tab " .. i })
end
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
end, { desc = "Select Tabs" })

--------------------------------------------- Buffer --------------------------------------------
-- Buffers
map("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First Buffer" })
map("n", "<leader>ba", "<cmd>blast<cr>", { desc = "Last Buffer" })
map("n", "<leader>b<tab>", "<cmd>tabnew %<cr>", { desc = "Current Buffer in New Tab" })

-------------------------------------------------------------------------------------------------
-- Add `,` or `;` to end of line.
---@param character string
---@return function
local function modify_line_end_delimiter(character)
  local delimiters = { ",", ";" }
  return function()
    local line = vim.api.nvim_get_current_line()
    local last_char = line:sub(-1)
    if last_char == character then
      vim.api.nvim_set_current_line(line:sub(1, #line - 1))
    elseif vim.tbl_contains(delimiters, last_char) then
      vim.api.nvim_set_current_line(line:sub(1, #line - 1) .. character)
    else
      vim.api.nvim_set_current_line(line .. character)
    end
  end
end

map("n", "<localleader>,", modify_line_end_delimiter(","), { desc = 'Add "," to end of line' })
map("n", "<localleader>;", modify_line_end_delimiter(";"), { desc = 'Add ";" to end of line' })

----------------------------------------- Windows ------------------------------------------------
map("n", "<localleader>w", "", { desc = "Windows" })
map("n", "<localleader>wh", "<C-W>t <C-W>K", { desc = "Horizontal   Vertical Splits" })
map("n", "<localleader>wv", "<C-W>t <C-W>H", { desc = "Vertical   Horizontal Splits" })
map("n", "<c-w>f", "<C-W>vgf", { desc = "Open File in Vert Split" })
map("n", "<localleader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<localleader>wq", "<cmd>bd!<cr>", { desc = "Close Current Buffer and Window" })
