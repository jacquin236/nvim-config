return {
  {
    "roobert/search-replace.nvim",
    opts = {
      default_replace_single_buffer_options = "gcI",
      default_replace_multi_buffer_options = "egcI",
    },
    keys = {
      { "<leader>srb", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", desc = "Buffer", mode = "v" },
      { "<leader>srv", "<CMD>SearchReplaceWithinVisualSelection<CR>", desc = "Visual Selection", mode = "v" },
      { "<leader>srw", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", desc = "Word on Buffer", mode = "v" },

      { "<leader>srb", "<CMD>SearchReplaceSingleBufferOpen<CR>", desc = "Buffer", mode = "n" },
      { "<leader>srw", "<CMD>SearchReplaceSingleBufferCWord<CR>", desc = "Word on Buffer", mode = "n" },
      { "<leader>srW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", desc = "WORD on Buffer", mode = "n" },
      { "<leader>sre", "<CMD>SearchReplaceSingleBufferCExpr<CR>", desc = "Expression on Buffer", mode = "n" },
      { "<leader>srf", "<CMD>SearchReplaceSingleBufferCFile<CR>", desc = "File on Buffer", mode = "n" },
    },
  },
  {
    "cshuaimin/ssr.nvim",
    opts = {},
    keys = {
      {
        "<leader>srs",
        function()
          require("ssr").open()
        end,
        desc = "Structural [ssr]",
      },
    },
  },
}
