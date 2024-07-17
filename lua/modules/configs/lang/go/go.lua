return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gowork", "gosum", "gotmpl" } },
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = function()
      require("go.install").update_all_sync()
    end,
    opts = {
      tag_transform = false,
      fillstruct = "gopls",
      log_path = vim.fn.stdpath("state") .. "/tmp/gonvim.log",
      lsp_codelens = true,
      lsp_gofumpt = true,
      dap_debug = true,
      gofmt = "gopls",
      goimports = "gopls",
      dap_debug_vt = true,
      dap_debug_gui = true,
      diagnostic = {
        signs = {
          text = { "🚑", "🔧", "🪛", "🪠" },
        },
        update_in_insert = false,
      },
      test_runner = "go",
      lsp_document_formatting = true,
      luasnip = true,
      lsp_cfg = false,
    },
    config = function(_, opts)
      require("go").setup(opts)
    end,
    keys = {
      { "<localleader>gu", "<cmd>GoUpdateBinaries<cr>", desc = "[go] update all tools" },
      { "<localleader>gt", "", desc = "[go] test" },
      { "<localleader>gtt", "<cmd>GoTest<cr>", desc = "[go] run test" },
      { "<localleader>gtf", "<cmd>GoTestFunc<cr>", desc = "[go] run test current function" },
      { "<localleader>gtn", "<cmd>GoTest -n<cr>", desc = "[go] test nearest" },
      { "<localleader>gtc", "<cmd>GoTestFile<cr>", desc = "[go] test current file" },
      { "<localleader>gl", "<cmd>GoLint<cr>", desc = "[go] lint" },
      { "<localleader>gC", "<cmd>GoTermClose<cr>", desc = "[go] close floating term" },
      { "<localleader>gd", "<cmd>GoDebug<cr>", desc = "[go] start debug session" },
      { "<localleader>gk", "<cmd>GoDbgKeys<cr>", desc = "[go] show debug keymaps" },
      { "<localleader>gm", "<cmd>GoMockGen<cr>", desc = "[go] generate mocks for current file" },
      {
        "<localleader>gg",
        function()
          require("go.comment").gen()
        end,
        desc = "[go] auto generate comment",
      },
      { "<localleader>gi", "<cmd>GoToggleInlay<cr>", desc = "[go] toggle inlay hints" },
      { "<localleader>gf", "<cmd>GoFillStruct<cr>", desc = "[go] fill struct" },
      { "<localleader>gp", "<cmd>GoFixPlurals<cr>", desc = "[go] fix plurals" },
      { "<localleader>ge", "<cmd>GoIfErr<cr>", desc = "[go] if error" },
      {
        "<localleader>go",
        function()
          require("go.format").gofmt()
        end,
        desc = "[go] format gofmt",
      },
      {
        "<localleader>gO",
        function()
          require("go.format").goimports()
        end,
        desc = "[go] format goimports + gofmt",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<localleader>g", group = "Go", icon = "" },
      },
    },
  },
}
