return {
  -- Import all plugins that I need
  { import = "plugins.extras.ui" },
  { import = "plugins.extras.themes" },
  { import = "plugins.extras.coding" },
  { import = "plugins.extras.lsp" },

  -- Treesitter plugins
  { import = "plugins.extras.coding.treesitter" },

  -- Editor plugins
  { import = "plugins.extras.editor" },

  -- Telescope
  { import = "plugins.extras.editor.telescope" },

  -- Git plugins
  { import = "plugins.extras.editor.git" },

  -- Languages
  { import = "plugins.extras.lang.web.typescript" },
  { import = "plugins.extras.lang.web.tailwind" },
  { import = "plugins.extras.lang.web.html-css" },
  { import = "plugins.extras.lang.bash" },
  { import = "plugins.extras.lang.go" },
  { import = "plugins.extras.lang.git" },
  { import = "plugins.extras.lang.json" },
  { import = "plugins.extras.lang.rust" },
  { import = "plugins.extras.lang.xml" },
  { import = "plugins.extras.lang.yaml" },

  -- Docs
  { import = "plugins.extras.editor.docs.neorg" },
  { import = "plugins.extras.editor.docs.orgmode" },

  -- Formatters
  { import = "plugins.extras.formatting.prettier" },
  { import = "plugins.extras.formatting.shfmt" },

  -- Enable some tools
  { import = "plugins.extras.tools.colorizer" },
  { import = "plugins.extras.tools.icon-picker" },
  { import = "plugins.extras.tools.project" },

  -- Debug
  { import = "plugins.extras.dap" },

  -- Test
  { import = "plugins.extras.test" },
}
