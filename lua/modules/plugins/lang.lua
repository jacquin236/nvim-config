return {
  { import = "modules.configs.lang.lspconfig" },

  -- Tools related to lsp
  { import = "modules.configs.lang.glance" },
  { import = "modules.configs.lang.inc-rename" },
  { import = "modules.configs.lang.symbol-usage" },
  { import = "modules.configs.lang.nvim-lightbulb" },

  -- Add supported icons for some filetypes
  { import = "modules.configs.lang.mini-icons" },

  -- List of languages
  { import = "modules.configs.lang.lsp.bash" },
  { import = "modules.configs.lang.lsp.clangd", enabled = false },
  { import = "modules.configs.lang.lsp.cmake", enabled = false },
  { import = "modules.configs.lang.lsp.docker" },
  { import = "modules.configs.lang.lsp.git" },
  { import = "modules.configs.lang.lsp.go", enabled = false },
  { import = "modules.configs.lang.lsp.haskell", enabled = false },
  { import = "modules.configs.lang.lsp.json" },
  { import = "modules.configs.lang.lsp.log" },
  { import = "modules.configs.lang.lsp.lua" },
  { import = "modules.configs.lang.lsp.markdown" },
  { import = "modules.configs.lang.lsp.omnisharp", enabled = false },
  { import = "modules.configs.lang.lsp.python", enabled = false },
  { import = "modules.configs.lang.lsp.ruby", enabled = false },
  { import = "modules.configs.lang.lsp.rust" },
  { import = "modules.configs.lang.lsp.sql" },
  { import = "modules.configs.lang.lsp.xml", enabled = false },
  { import = "modules.configs.lang.lsp.yaml" },

  -- Web/app sepcific tools/languages
  { import = "modules.configs.lang.web.curl" },
  { import = "modules.configs.lang.web.graphql", enabled = false },
  { import = "modules.configs.lang.web.html-css" },
  { import = "modules.configs.lang.web.live-server" },
  { import = "modules.configs.lang.web.php", enabled = false },
  { import = "modules.configs.lang.web.rest" },
  { import = "modules.configs.lang.web.svelte", enabled = false },
  { import = "modules.configs.lang.web.tailwind" },
  { import = "modules.configs.lang.web.typescript" },
  { import = "modules.configs.lang.web.vue", enabled = false },

  -- Debug
  { import = "modules.configs.lang.debug.core" }, -- Main
  { import = "modules.configs.lang.debug.extras" },
  -- Debug adapters for specific languages
  -- Disable any language adapters you don't need.
  -- At the moment I work with mostly `lua` and `rust`
  { import = "modules.configs.lang.debug.languages.bash", enabled = false },
  { import = "modules.configs.lang.debug.languages.go", enabled = false },
  { import = "modules.configs.lang.debug.languages.lua" },
  { import = "modules.configs.lang.debug.languages.omnisharp", enabled = false },
  { import = "modules.configs.lang.debug.languages.python", enabled = false },
  { import = "modules.configs.lang.debug.languages.ruby", enabled = false },
  { import = "modules.configs.lang.debug.languages.rust" },
  { import = "modules.configs.lang.debug.languages.typescript", enabled = false },

  -- Testing
  -- Neotest adapters
  { import = "modules.configs.lang.testing.core" }, -- Main
  { import = "modules.configs.lang.testing.languages.bash", enabled = false },
  { import = "modules.configs.lang.testing.languages.lua" },
  { import = "modules.configs.lang.testing.languages.omnisharp", enabled = false },
  { import = "modules.configs.lang.testing.languages.python", enabled = false },
  { import = "modules.configs.lang.testing.languages.ruby", enabled = false },
  { import = "modules.configs.lang.testing.languages.rust" },
  { import = "modules.configs.lang.testing.languages.typescript", enabled = false },
}
