return {
  "xiyaowong/nvim-transparent",
  cmd = { "TransparentEnable", "TransparentToggle", "TransparentDisable" },
  keys = {
    { "<localleader>t",  "<cmd>TransparentToggle<cr>",  desc = "Toggle Transparent" },
    { "<localleader>to", "<cmd>TransparentEnable<cr>",  desc = "Enable Transparent" },
    { "<localleader>tf", "<cmd>TransparentDisable<cr>", desc = "Disable Transparent" },
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
