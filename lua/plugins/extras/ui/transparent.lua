return {
  {
    "xiyaowong/nvim-transparent",
    cmd = { "TransparentEnable", "TransparentToggle", "TransparentDisable" },
    keys = {
      { "<leader>uY", "<Cmd>TransparentToggle<CR>", desc = "Toggle Transparent" },
    },
    config = function()
      if vim.g.transparent_enabled ~= true then
        if package.loaded["ayu"] then
          require("ayu").setup({
            overrides = {
              Normal = { bg = "None" },
              ColorColumn = { bg = "None" },
              SignColumn = { bg = "None" },
              Folded = { bg = "None" },
              FoldColumn = { bg = "None" },
              CursorLine = { bg = "None" },
              CursorColumn = { bg = "None" },
              WhichKeyFloat = { bg = "None" },
              VertSplit = { bg = "None" },
            },
          })
        end
      end

      local transparent = require("transparent")
      transparent.clear_prefix("NeoTree")
      transparent.setup({
        extra_groups = {
          "NormalFloat",
          "FloatBorder",
          "Pmenu",
          "WinSeparator",
          "Statusline",
          "StatuslineNC",
          "VertSplit",
          "Folded",
          "TelescopeNormal",
        },
      })
    end,
  },
}
