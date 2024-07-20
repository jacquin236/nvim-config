return {
  {
    "vidocqh/auto-indent.nvim",
    event = "LazyFile",
    opts = {
      lightmode = true,
      ---@param lnum: number
      ---@return number
      indentexpr = function(lnum)
        return require("nvim-treesitter.indent").get_indent(lnum)
      end,
    },
    config = function(_, opts)
      require("auto-indent").setup(opts)
    end,
  },
}
