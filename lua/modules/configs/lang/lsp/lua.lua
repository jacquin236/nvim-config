return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              type = { castNumbertoInteger = true },
              diagnostics = {
                globals = { "vim" },
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
                checkThirdParty = false,
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
              },
              doc = { privateName = { "^_" } },
              telemetry = { enable = false },
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
