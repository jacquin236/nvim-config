return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      
      -- stylua: ignore start
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>cil", "<cmd>LspInfo<cr>", desc = "Lsp" }
      keys[#keys + 1] = { "<leader>clr", "<cmd>LspRestart<cr>", desc = "Restart Lsp" }
      keys[#keys + 1] = { "<leader>cls", "<cmd>LspStart<cr>", desc = "Start Lsp" }
      keys[#keys + 1] = { "<leader>clS", "<cmd>LspStop<cr>", desc = "Stop Lsp" }
      keys[#keys + 1] = { "<leader>clR", function() vim.lsp.buf.remove_workspace_folder() end, desc = "Remove workspace" }
      keys[#keys + 1] = { "<leader>cla", function() vim.lsp.buf.add_workspace_folder() end, desc = "Add workspace" }
      -- stylua: ignore end
    end,
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        virtual_text = { prefix = "icons" },
      },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      ---@type lspconfig.options
      servers = {},
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {},
    },
  },
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", false },
      { "<leader>im", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>cl", group = "lsp", icon = "󰅟 " },
      },
    },
  },
}
