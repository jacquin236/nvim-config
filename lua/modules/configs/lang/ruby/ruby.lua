vim.filetype.add({
  filename = {
    Podfile = "ruby",
    Brewfile = "ruby",
  },
})

if lazyvim_docs then
  vim.g.lazyvim_ruby_lsp = "ruby_lsp"
  vim.g.lazyvim_ruby_formatter = "rubocop"
end

local lsp = vim.g.lazyvim_ruby_lsp or "ruby_lsp"
local formatter = vim.g.lazyvim_ruby_formatter or "rubocop"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ruby" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "erb-formatter", "erb-lint" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {
          autostart = false,
          filetypes = { "ruby", "eruby" },
          settings = {
            solargraph = {
              useBundler = true,
              diagnostic = true,
              completion = true,
              hover = true,
              formatting = true,
              symbols = true,
              definitions = true,
              rename = true,
              references = true,
              folding = true,
            },
          },
        },
        ruby_lsp = { enabled = lsp == "ruby_lsp" },
        rubocop = { enabled = lsp == "rubocop" },
        standardrb = { enabled = formatter == "standardrb" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      vim.list_extend(opts.formatters_by_ft, {
        ruby = { formatter },
        eruby = { "erb-formatter" },
      })
    end,
  },
  {
    "tpope/vim-rails",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "tpope/vim-abolish",
      "tpope/vim-bundler",
      "tpope/vim-endwise",
      "tpope/vim-dispatch",
    },
    ft = { "ruby", "eruby" },
    opts = {},
  },
}
