return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { bold = true },
        statementStyle = { bold = true },
        typeStype = {},
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        theme = "dragon",
      })
    end,
  },
}
