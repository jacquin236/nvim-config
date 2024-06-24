return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    config = function()
      require("bamboo").setup({
        style = "vulgaris",
        transparent = false,
        dim_inactive = false,
        term_colors = true,
        code_style = {
          comments = { italic = true },
          conditionals = { italic = false, bold = true },
          keywords = { bold = true },
        },
        lualine = {
          transparent = false,
        },
      })
    end,
  },
}
