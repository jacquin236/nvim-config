return {
  "sainnhe/sonokai",
  lazy = false,
  name = "sonokai",
  config = function()
    vim.g.sonokai_enable_italic = true
    vim.g.sonokai_better_performance = true
    vim.g.sonokai_transparent_background = vim.g.transparent_enabled
    vim.g.sonokai_style = "maia" -- could be "default", "atlantis", "andromeda", "shusia", "maia" or "espresso"
  end,
}
