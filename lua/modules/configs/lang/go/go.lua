local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").gofmt()
  end,
  group = format_sync_grp,
})

return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gowork", "gotmpl" },
    build = function()
      require("go.install").update_all_sync()
    end,
    opts = {
      fillstruct = "gopls",
      goimports = "gopls",
      gofmt = "gopls",
      log_path = vim.fn.stdpath("state") .. "/gonvim.log",
      lsp_gofumpt = true,
      lsp_document_formatting = true,
      lsp_keymaps = true,
      lsp_codelens = true,
      lsp_inlay_hints = {
        enable = true,
        style = "inlay",
      },
      diagnostic = {
        update_in_insert = false,
        signs = { "🚑", "🔧", "🪛", "🪠" },
        virtual_text = { spacing = 4, prefix = "✿ " },
        underline = true,
      },
      dap_debug = true,
      dap_debug_keymap = false,
      dap_debug_gui = true,
      testobjects = true,
      test_runner = "go",
      test_efm = false,
      trouble = true,
      luasnip = true,
      null_ls_document_formatting_disable = true,
      preludes = {},
    },
    config = function(_, opts)
      require("go").setup(opts)
    end,
  },
}
