return {
  {
    "xiyaowong/nvim-transparent",
    cmd = { "TransparentEnable", "TransparentToggle", "TransparentDisable" },
    keys = {
      { "<leader>uP", "<Cmd>TransparentToggle<CR>", desc = "Toggle Transparent" },
    },
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat",
          "Pmenu",
        },
      })
    end,
  },
}
