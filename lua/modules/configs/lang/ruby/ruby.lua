vim.filetype.add({
  filename = {
    Podfile = "ruby",
    Brewfile = "ruby",
  },
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ruby" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {
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
      },
    },
  },
}
