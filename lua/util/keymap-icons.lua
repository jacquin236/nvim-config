---@type wk.IconRule[]
return {
  -------------------------------------------- Plugins -------------------------------------------
  -- debug
  { plugin = "debugprint.nvim", icon = "󰹜 ", color = "blue" },
  { plugin = "nvim-dap", icon = "🎯", color = "red" },
  { plugin = "nvim-dap-ui", icon = "🐞 ", color = "red" },
  { plugin = "persistent-breakpoints.nvim", icon = " ", color = "azure" },
  { plugin = "telescope-dap.nvim", icon = "🐛", color = "grey" },
  -- test
  { plugin = "neotest", icon = "󰙨 ", color = "azure" },

  -- git
  { plugin = "octo.nvim", icon = " ", color = "grey" },
  { plugin = "openingh.nvim", icon = " ", color = "orange" },
  { plugin = "gist.nvim", icon = " ", color = "green" },
  { plugin = "git-worktree.nvim", icon = "󱘎 ", color = "azure" },
  --crates
  { plugin = "crates.nvim", icon = "📦", color = "yellow" },
  -- neogen
  { plugin = "neogen", icon = "󰙆 ", color = "blue" },
  -- trouble
  { plugin = "trouble.nvim", icon = "󰁨 ", color = "yellow" },
  ------------------------------------------- Patterns -------------------------------------------
  { pattern = "debug", icon = " ", color = "red" },
  { pattern = "test", icon = " ", color = "yellow" },
  { pattern = "database", icon = " ", color = "yellow" },
  { pattern = "dbee", icon = "🐝", color = "orange" },

  -- plugin
  { pattern = "plugin", icon = "󰐱 ", color = "green" },
  -- git
  { pattern = "github", icon = " ", color = "blue" },
  { pattern = "hunk", icon = " ", color = "grey" },
  -- ui
  { pattern = "colorscheme", icon = " ", color = "azure" },
  --packages/dependencies
  { pattern = "dependencies", icon = " ", color = "orange" },
  { pattern = "rust", icon = "🦀 ", color = "red" },
  { pattern = "yaml", icon = " ", color = "orange" },
  { pattern = "schema", icon = " ", color = "orange" },
  { pattern = "web", icon = "🌏", color = "blue" },
  { pattern = "app", icon = "🌏", color = "blue" },
  -- annotation/snippets
  { pattern = "annotation", icon = " ", color = "azure" },
  { pattern = "snippets", icon = " ", color = "azure" },
  -- docs/notes
  { pattern = "notes", icon = "󱓧 ", color = "azure" },
  { pattern = "orgmode", icon = " ", color = "green" },
  { pattern = "neorg", icon = "󰎖 ", color = "cyan" },
  { pattern = "devdocs", icon = " ", color = "grey" },
  -- icon pickers
  { pattern = "icons", icon = " ", color = "orange" },
  { pattern = "conform", icon = "󰁨 ", color = "blue" },
  { pattern = "lint", icon = "󰁨 ", color = "blue" },
  { pattern = "cmp", icon = " ", color = "red" },
  { pattern = "root", icon = "󰆥 ", color = "yellow" },

  ----------------------------------------- Miscellanous ----------------------------------------

  { pattern = "window", icon = "󱂬 ", color = "blue" },
  { pattern = "buffer", icon = "󰖯 ", color = "cyan" },
  { pattern = "info", icon = " ", color = "green" },
  { pattern = "grep", icon = " ", color = "green" },
  { pattern = "keywordprg", icon = "󰌆 ", color = "green" },
  { pattern = "spell", icon = "󰓆 ", color = "purple" },
  { pattern = "command", icon = " ", color = "orange" },
  { pattern = "history", icon = " ", color = "purple" },
  { pattern = "breakpoint", icon = "󰙦 ", color = "red" },
  { pattern = "move", icon = "󰆾 ", color = "grey" },
  { pattern = "change", icon = "󰞯 ", color = "yellow" },

  { pattern = "help", icon = "", color = "red" },
  { pattern = "copy", icon = " ", color = "green" },
  { pattern = "paste", icon = " ", color = "cyan" },
  { pattern = "select", icon = "󰾂 ", color = "orange" },
  { pattern = "redo", icon = "󰑎 ", color = "yellow" },
  { pattern = "up", icon = " ", color = "blue" },
  { pattern = "down", icon = " ", color = "blue" },
  { pattern = "left", icon = " ", color = "blue" },
  { pattern = "right", icon = " ", color = "blue" },
  { pattern = "node", icon = "󰭅 ", color = "yellow" },
  { pattern = "filter", icon = " ", color = "blue" },

  { pattern = "last", icon = "󰘁 ", color = "grey" },
  { patterm = "first", icon = "󰘀 ", color = "grey" },
  { pattern = "replace", icon = "󰛔 ", color = "grey" },
  { pattern = "flash", icon = "󰉁 ", color = "azure" },

  { pattern = "quit", icon = " ", color = "grey" },
  { pattern = "diagnostic", icon = "󱄪 ", color = "yellow" },
  { pattern = "connection", icon = "󱘖 ", color = "azure" },
  { pattern = "inspect", icon = " ", color = "green" },
}
