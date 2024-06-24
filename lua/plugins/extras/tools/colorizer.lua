return {
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = {
      "Colorize",
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerToggle",
      "ColorizerReloadAllBuffers",
    },
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          css = true,
          tailwind = true,
          mode = "virtualtext",
        },
      })
      vim.api.nvim_create_user_command("Colorize", "ColorizerToggle", {})
    end,
  },
}
