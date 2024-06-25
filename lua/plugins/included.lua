return {
  -- Import all plugins that I need
  { import = "plugins.extras.ui" },
  { import = "plugins.extras.themes" },
  { import = "plugins.extras.coding" },
  { import = "plugins.extras.lsp" },
  { import = "plugins.extras.themes" },

  -- Treesitter plugins
  { import = "plugins.extras.coding.treesitter" },

  -- Editor plugins
  { import = "plugins.extras.editor" },

  -- Telescope
  { import = "plugins.extras.editor.telescope" },

  -- Git plugins
  { import = "plugins.extras.editor.git" },

  -- Language
  { import = "plugins.extras.lang.web.typescript" },
  { import = "plugins.extras.lang.web.tailwind" },
  { import = "plugins.extras.lang.web.html-css" },
  { import = "plugins.extras.lang.bash" },
  { import = "plugins.extras.lang.json" },
  { import = "plugins.extras.lang.yaml" },
  { import = "plugins.extras.lang.xml" },
  { import = "plugins.extras.lang.markdown" },
  { import = "plugins.extras.lang.go" },
  { import = "plugins.extras.lang.sql" },
  { import = "plugins.extras.lang.rust" },

  -- Formatting
  { import = "plugins.extras.formatting.prettier" },
  { import = "plugins.extras.formatting.shfmt" },

  -- Docs
  { import = "plugins.extras.editor.docs.devdocs" },
  { import = "plugins.extras.editor.docs.neorg" },
  { import = "plugins.extras.editor.docs.orgmode" },

  -- Enable some tools
  { import = "plugins.extras.tools.colorizer" },
  { import = "plugins.extras.tools.icon-picker" },
  { import = "plugins.extras.tools.project" },

  -- Debug
  { import = "plugins.extras.dap" },

  -- Test
  { import = "plugins.extras.test" },
}
