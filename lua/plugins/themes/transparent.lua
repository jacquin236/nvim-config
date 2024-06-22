return {
  "xiyaowong/nvim-transparent",
  cmd = { "TransparentEnable", "TransparentToggle", "TransparentDisable" },
  keys = {
    { "<localleader>t", "<cmd>TransparentToggle<cr>", desc = "Transparent: Toggle" },
    { "<localleader>to", "<cmd>TransparentEnable<cr>", desc = "Transparent: Enable" },
    { "<localleader>tf", "<cmd>TransparentDisable<cr>", desc = "Transparent: Disable" },
  },
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalFloat",
        "Pmenu",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
      },
    })
  end,
}
