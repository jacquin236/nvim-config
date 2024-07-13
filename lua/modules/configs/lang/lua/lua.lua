return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                didChangeWatchedFiles = { dynamicRegistration = false },
                library = {
                  vim.fn.expand("$VIMRUNTIME/lua"),
                  vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                  vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
              codeLens = { enable = false },
              completion = {
                enable = true,
                callSnippet = "Both",
                keywordSnippet = "Replace",
                displayContext = 4,
              },
              doc = { privateName = { "^_" } },
              type = { castNumberToInteger = true },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              telemetry = { enable = false },
              diagnostics = {
                globals = { "vim" },
                disable = { "incomplete-signature-doc", "trailing-space", "undefined-field" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                unusedLocalExclude = { "_*" },
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
                workspaceEvent = "OnChange",
              },
              hover = { enable = true },
            },
          },
        },
      },
    },
  },
}
