return {
  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "ColorizerToggle",
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
    opts = {
      user_default_options = {
        names = false,
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        always_update = true,
      },
    },
    keys = {
      { "<leader>cct", "<cmd>ColorizerToggle<cr>", desc = "[colorizer] Toggle" },
      { "<leader>cca", "<cmd>ColorizerAttachToBuffer<cr>", desc = "[colorizer] Attach To Buffer" },
      { "<leader>ccd", "<cmd>ColorizerDetachFromBuffer<cr>", desc = "[colorizer] Detach From Buffer" },
      { "<leader>ccr", "<cmd>ColorizerReloadAllBuffers<cr>", desc = "[colorizer] Reload All Buffers" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>cc", group = "Colorizer" },
      },
    },
  },
}
