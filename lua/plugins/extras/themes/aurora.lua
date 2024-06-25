return {
  "ray-x/aurora",
  lazy = false,
  config = function()
    vim.g.aurora_italic = 1
    vim.g.aurora_bold = 1
    vim.g.aurora_darker = 1
    vim.g.aurora_transparent = vim.g.transparent_enabled
  end,
}
