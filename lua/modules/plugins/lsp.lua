return {
  { import = "modules.configs.lsp" },
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    cmd = "LspStart",
    init = function()
      -- stylua: ignore start
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>il", "<cmd>LspInfo<cr>", desc = "LSP" }
      keys[#keys + 1] = { "<leader>clr", "<cmd>LspRestart<cr>", desc = "[lsp] Restart" }
      keys[#keys + 1] = { "<leader>cls", "<cmd>LspStart<cr>", desc = "[lsp] Start" }
      keys[#keys + 1] = { "<leader>clS", "<cmd>LspStop<cr>", desc = "[lsp] Stop" }
      keys[#keys + 1] = { "<leader>clr", function() vim.lsp.buf.remove_workspace_folder() end, desc = "[lsp] Remove workspace" }
      keys[#keys + 1] = { "<leader>cla", function() vim.lsp.buf.add_workspace_folder() end, desc = "[lsp] Add workspace" }

      keys[#keys + 1] = { "gd", vim.lsp.buf.definition(), desc = "[lsp] Definition", has = "definition" }
      keys[#keys + 1] = { "gr", vim.lsp.buf.references(), desc = "[lsp] References", nowait = true }
      keys[#keys + 1] = { "gI", vim.lsp.buf.implementation(), desc = "[lsp] Implementation" }
      keys[#keys + 1] = { "gy", vim.lsp.buf.type_definition(), desc = "[lsp] T[y]pe Definition" }
      keys[#keys + 1] = { "gD", vim.lsp.buf.declaration, desc = "[lsp] Declaration" }
      keys[#keys + 1] = { "gK", vim.lsp.buf.signature_help, desc = "[lsp] Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = { "K", vim.lsp.buf.hover, desc = "Hover" }

      keys[#keys + 1] = { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "[lsp] Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = { "<leader>ca", vim.lsp.buf.code_action, desc = "[lsp] Code Action", mode = { "n", "v" }, has = "codeAction" }
      keys[#keys + 1] = { "<leader>cc", vim.lsp.codelens.run, desc = "[lsp] Run Codelens", mode = { "n", "v" }, has = "codeLens" }
      keys[#keys + 1] = { "<leader>cC", vim.lsp.codelens.refresh, desc = "[lsp] Refresh & Display Codelens", mode = { "n" }, has = "codeLens" }
      keys[#keys + 1] = { "<leader>cR", LazyVim.lsp.rename_file, desc = "[lsp] Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } }
      keys[#keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "[lsp] Rename", has = "rename" }
      keys[#keys + 1] = { "<leader>cA", LazyVim.lsp.action.source, desc = "[lsp] Source Action", has = "codeAction" }

      keys[#keys + 1] = { "]]", function() LazyVim.lsp.words.jump(vim.v.count1) end, has = "documentHighlight",
        desc = "[lsp] Next Reference", cond = function() return LazyVim.lsp.words.enabled end }
      keys[#keys + 1] = { "[[", function() LazyVim.lsp.words.jump(-vim.v.count1) end, has = "documentHighlight",
        desc = "[lsp] Prev Reference", cond = function() return LazyVim.lsp.words.enabled end }
      keys[#keys + 1] = { "<a-n>", function() LazyVim.lsp.words.jump(vim.v.count1, true) end, has = "documentHighlight",
        desc = "[lsp] Next Reference", cond = function() return LazyVim.lsp.words.enabled end }
      keys[#keys + 1] = { "<a-p>", function() LazyVim.lsp.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
        desc = "[lsp] Prev Reference", cond = function() return LazyVim.lsp.words.enabled end }
      -- stylua: ignore end
    end,
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          prefix = "icons",
          float = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
          },
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      inlay_hints = { enabled = true, exclude = { "vue" } },
      document_highlight = { enabled = true },
      capabilities = {
        workspace = {
          fileOperations = { didRename = true, willRename = true },
          didChangeWatchedFiles = { dynamicRegistration = false },
        },
      },
      servers = {},
      setup = {},
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>cl", group = "Lsp" },
      },
    },
  },
}
