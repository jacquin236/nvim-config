return {
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  opts = {
    priority = 40,
    autocmd = {
      enabled = true
    },
    sign = {
      enabled = false
    },
    action_kinds = { "quickfix", "refactor" },
    ignore = {
      actions_without_kind = true
    },
    float = {
      text = require("util.icons").misc.Lightbulb,
      enabled = true,
      win_opts = {
        norder = "none"
      },
    },
  },
}
