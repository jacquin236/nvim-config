local autocmd = vim.api.nvim_create_autocmd

-- Disable diagnostics in a .env file
autocmd("BufRead", {
  pattern = ".env",
  callback = function()
    vim.diagnostic.disable(false)
  end,
})

-- Do not list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Plain terminals
autocmd("TermOpen", {
  pattern = "term://*",
  command = [[setlocal listchars= nonumber norelativenumber | startinsert]],
})

-- markdown file
autocmd("FileType", {
  pattern = "markdown",
  callback = function(event)
    vim.schedule(function()
      require("noice.text.markdown").keys(event.buf)
    end)
  end,
})

-- autowrap on text-based file
autocmd("FileType", {
  pattern = { "text", "tex", "markdown", "rst" },
  callback = function()
    vim.wo.wrap = true
  end,
})

-- show cursorline only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- indent line (non-blankline only)
autocmd("OptionSet", {
  pattern = { "list" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lead = "│"
    for i = 1, vim.bo[bufnr].tabstop - 1 do
      lead = lead .. " "
    end
    vim.opt_local.listchars:append({ leadmultispace = lead })
  end,
})

-- Auto close window when leaving
local auto_close_filetype = {
  "lazy",
  "mason",
  "lspinfo",
  "toggleterm",
  "null-ls-info",
  "TelescopePrompt",
  "notify",
}
autocmd("BufLeave", {
  group = vim.api.nvim_create_augroup("lazyvim_auto_close_win", { clear = true }),
  callback = function()
    local ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
    if vim.fn.index(auto_close_filetype, ft) ~= -1 then
      local winids = vim.fn.win_findbuf(event.buf)
      for _, win in pairs(winids) do
        vim.api.nvim_win_close(win, true)
      end
    end
  end
})

-- Disable leader and localleader for some filetypes
autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazyvim_unbind_leader_key", { clear = true }),
  pattern = {
    "lazy",
    "mason",
    "lspinfo",
    "toggleterm",
    "null-ls-info",
    "neo-tree-popup",
    "TelescopePrompt",
    "notify",
    "floaterm",
  },
  callback = function(event)
    vim.keymap.set("n", "<leader>", "<nop>", { buffer = event.buf, desc = "" })
    vim.keymap.set("n", "<localleader>", "<nop>", { buffer = event.buf, desc = "" })
  end,
})

-- Colors
local function mod_hl(opts, hl_names)
  for _, hl in ipairs(hl_names) do
    local hl_def = vim.api.nvim_get_hl(0, { name = hl })
    for k, v in pairs(opts) do
      hl_def[k] = v
    end
    local ok, _ = pcall(vim.api.nvim_set_hl, 0, hl, hl_def)
    if not ok then
      vim.pretty_print("Failed to set highlight " .. hl)
    end
  end
end

local update_highlight = function()
  mod_hl({ bold = true, italic = true }, {
    "@type.builtin",
    "@module.builtin",
    "@constant.builtin",
    "@function.builtin",
    "@variable.builtin",
    "@variable.parameter.builtin",
    "@boolean",
  })
  mod_hl({ bold = true }, {
    "@type",
    "@constructor",
  })
  mod_hl({ italic = true }, {
    "@comment",
    "@variable.parameter",
  })

  if not LazyVim.ui.color("IlluminatedWordText", true) and LazyVim.ui.color("LSPReferenceText", true) then
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LSPReferenceText" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LSPReferenceText" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LSPReferenceText" })
  end
  vim.cmd([[
      " highlight! Folded guibg=NONE
      highlight! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE
      ]])
end

autocmd(
  { "ColorScheme", "SessionLoadPost" },
  { group = vim.api.nvim_create_augroup("Color", {}), callback = update_highlight }
)
autocmd({ "BufReadPost" }, {
  group = vim.api.nvim_create_augroup("Color", { clear = false }),
  callback = update_highlight,
  once = true,
})

if vim.version().minor >= 10 then
  autocmd("LspProgress", {
    callback = function(args)
      if string.find(args.match, "end") then
        vim.cmd("redrawstatus")
      end
      vim.cmd("redrawstatus")
    end,
  })
end

-- Toggle between relative/absolute line numbers
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = numbertoggle,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = numbertoggle,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd.redraw()
    end
  end,
})

--Create a dir when saving a file if it doesnt exist
autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(args)
    if args.match:match("^%w%w+://") then return end
    local file = vim.uv.fs_realpath(args.match) or args.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end
})