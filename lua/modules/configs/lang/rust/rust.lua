return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          autoSetHints = true,
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
          },
        },
        server = {
          on_attach = function(_, bufnr)
            local map = vim.keymap.set
            -- stylua: ignore start
            map("n", "<leader>rc", function() vim.cmd.RustLsp("codeAction") end, { desc = "[rust] Code Action", buffer = bufnr, silent = true })
            map("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, { desc = "[rust] Debuggables", buffer = bufnr, silent = true })
            map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, { desc = "[rust] Runnables", buffer = bufnr, silent = true })
            map("n", "K", function() vim.cmd.RustLsp{ "hover", "actions" } end, { desc = "[rust] Hover", buffer = bufnr, silent = true })
            map("n", "<leader>rh", function() vim.cmd.RustLsp({ "hover", "actions" }) end, { desc = "[rust] Hover", buffer = bufnr, silent = true })
            map("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end, { desc = "[rust] Testables", buffer = bufnr, silent = true })
            -- stylua: ignore end
          end,

          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
                allFeatures = true,
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate",
              },
              completion = {
                postfix = { enable = false },
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },
              inlayHints = {
                lifetimeElisionHints = { enable = true, useParameterNames = true },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "rust", "ron", "toml" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "taplo", "rust-analyzer" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
}
