return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      capabilities = {
        workspace = { didChangeWatchedFiles = { dynamicRegistration = false } },
      },
      servers = {
        lua_ls = {
          single_file_support = true,
          root_dir = function()
            local root_files = {
              ".git",
              ".luarc.json",
              ".luarc.jsonc",
              ".luacheckrc",
              ".stylua.toml",
              "stylua.toml",
              "selene.toml",
              "selene.yml",
            }
            return vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1])
          end,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              type = { castNumbertoInteger = true },
              diagnostics = {
                globals = { "vim", "describe", "it", "assert", "stub" },
                disable = { "incomplete-signature-doc", "trailing-space" },
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
              workspace = {
                checkThirdParty = "Disable",
                didChangeWatchedFiles = { dynamicRegistration = false },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
              codeLens = { enable = false },
              completion = {
                enable = true,
                callSnippet = "Both",
                keywordSnippet = "Replace",
                displayContext = 4,
                postfix = ".",
                showWord = "Disable",
                workspaceWord = false,
              },
              doc = { privateName = { "^_" } },
              telemetry = { enable = false },
              hint = {
                enable = true,
                setType = true,
                arrayIndex = "Disable",
                semiColon = "Disable",
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "selene", "luacheck" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
          end,
        },
      },
    },
  },

  { import = "modules.configs.lang.lsp.extras.lua-library" },
}
