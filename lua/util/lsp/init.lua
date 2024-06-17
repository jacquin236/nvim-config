local border = require("util.ui").border

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

local icons = require("util.ui").icons.diagnostics

lspSymbol("Error", icons.BoldError)
lspSymbol("Info", icons.BoldInformation)
lspSymbol("Hint", icons.BoldHint)
lspSymbol("Warn", icons.BoldWarning)

vim.diagnostic.config({
  virtual_text = {
    prefix = "",
  },
  signs = true,
  underline = true,
  -- update_in_insert = false,

  float = {
    border = border,
  },
})

--  LspInfo window borders
local win = require("lspconfig.ui.windows")
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = border
  return opts
end
