---@diagnostic disable: missing-fields
return {
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = { dynamicRegistration = false },
        },
        textDocument = {
          completion = {
            completionItem = {
              documentationFormat = { "markdown", "plaintext" },
              snippetSupport = true,
              preselectSupport = true,
              insertReplaceSupport = true,
              labelDetailsSupport = true,
              deprecatedSupport = true,
              commitCharactersSupport = true,
              tagSupport = { valueSet = { 1 } },
              resolveSupport = {
                properties = {
                  "documentation",
                  "detail",
                  "additionalTextEdits",
                },
              },
            },
          },
        },
      },
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
            },
          },
        },
      },
    },
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      priority = 40,
      autocmd = { enabled = true },
      sign = { enabled = false },
      action_kinds = { "quickfix", "refactor" },
      ignore = {
        actions_without_kind = true,
      },
      float = {
        text = require("util.icons").misc.Lightbulb,
        enabled = true,
        win_opts = { norder = "none" },
      },
    },
  },
  {
    "DNLHC/glance.nvim",
    lazy = true,
    opts = {
      preview_win_opts = { relativenumber = false },
      theme = { enable = true, mode = "darken" },
    },
    keys = {
      { "gD", "<cmd>Glance definitions<cr>",      desc = "Lsp: Glance Definitions" },
      { "gR", "<cmd>Glance references<cr>",       desc = "Lsp: Glance References" },
      { "gY", "<cmd>Glance type_definitions<cr>", desc = "Lsp: Glance Type Definitions" },
      { "gM", "<cmd>Glance implementations<cr>",  desc = "Lsp: Glance implementations" },
    },
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = {
      text_format = function(symbol)
        local res = {}
        local separator = require("util.icons").separators

        local roundstart = { separator.BubbleRight, "SymbolUsageRounding" }
        local roundend = { separator.BubbleLeft, "SymbolUsageRounding" }

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(res, roundstart)
          table.insert(res, { "󰌹 ", "SymbolUsageRef" })
          table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
          table.insert(res, roundend)
        end

        if symbol.definition then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, roundstart)
          table.insert(res, { "󰳽 ", "SymbolUsageDef" })
          table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
          table.insert(res, roundend)
        end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, roundstart)
          table.insert(res, { "󰡱 ", "SymbolUsageImple" })
          table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
          table.insert(res, roundend)
        end

        return res
      end,
    },
  },
}
