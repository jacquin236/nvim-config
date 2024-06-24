return {
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  opts = {
    priority = 40,
    autocmd = {
      enabled = true
    },
    sign = {
      enabled = true, text = require("util.icons").misc.Ligthbulb
    },
    action_kinds = { "quickfix", "refactor" },
    ignore = {
      actions_without_kind = true
    },
    float = { enabled = false },
  },
}
