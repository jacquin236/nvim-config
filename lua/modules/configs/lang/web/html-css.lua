return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "html", "css", "scss" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "emmet-language-server",
        "html-lsp",
        "css-lsp",
        "htmlhint",
        "stylelint",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_language_server = {},
        html = {},
        cssls = {
          lint = {
            compatibleVendorPrefixes = "ignore",
            vendorPrefix = "ignore",
            unknownVendorSpecificProperties = "ignore",

            -- unknownProperties = "ignore", -- duplicate with stylelint

            duplicateProperties = "warning",
            emptyRules = "warning",
            importStatement = "warning",
            zeroUnits = "warning",
            fontFaceProperties = "warning",
            hexColorLength = "warning",
            argumentsInColorFunction = "warning",
            unknownAtRules = "warning",
            ieHack = "warning",
            propertyIgnoredDueToDisplay = "warning",
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local stylelint = "stylelint"

      local function add_linters(tbl)
        for ft, linters in pairs(tbl) do
          if opts.linters_by_ft[ft] == nil then
            opts.linters_by_ft[ft] = linters
          else
            vim.list_extend(opts.linters_by_ft[ft], linters)
          end
        end
      end

      add_linters({
        ["html"] = { "htmlhint" },
        ["css"] = { stylelint },
        ["scss"] = { stylelint },
        ["less"] = { stylelint },
        ["sugarss"] = { stylelint },
        ["vue"] = { stylelint },
        ["wxss"] = { stylelint },
        ["javascript"] = { stylelint },
        ["javascriptreact"] = { stylelint },
        ["typescript"] = { stylelint },
        ["typescriptreact"] = { stylelint },
      })
      return opts
    end,
  },
  {
    "malbertzard/inline-fold.nvim",
    init = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "*.html", "*.tsx", "*.jsx" },
        callback = function(_)
          if not require("inline-fold.module").isHidden then
            vim.cmd("InlineFoldToggle")
          end
        end,
      })
    end,
    ft = "html",
    cmd = { "InlineFoldToggle" },
    opts = {
      defaultPlaceholder = "…",
      queries = {
        html = {
          { pattern = 'class="([^"]*)"' },
          { pattern = 'href="(.-)"' },
          { pattern = 'src="(.-)"' },
        },
      },
    },
    keys = {
      { "<leader>uI", "<cmd>InlineFoldToggle<CR>", desc = "Toggle Inline Fold" },
    },
  },
}
