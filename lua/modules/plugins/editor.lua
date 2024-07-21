return {
  -- navigation
  { import = "modules.configs.editor.navigation.which-key" },
  { import = "modules.configs.editor.navigation.undotree" },
  { import = "modules.configs.editor.navigation.neotree" },
  { import = "modules.configs.editor.navigation.toggleterm" },
  { import = "modules.configs.editor.navigation.hover" },
  { import = "modules.configs.editor.navigation.grug-far" },

  -- telescope
  { import = "modules.configs.editor.telescope" },
  { import = "modules.configs.editor.telescope.extras.telescope-file-browser" },
  { import = "modules.configs.editor.telescope.extras.telescope-heading" },
  { import = "modules.configs.editor.telescope.extras.telescope-import" },
  { import = "modules.configs.editor.telescope.extras.telescope-lazy" },
  { import = "modules.configs.editor.telescope.extras.telescope-undo" },

  -- tools
  { import = "modules.configs.editor.tools.colorizer" },
  { import = "modules.configs.editor.tools.icon-picker" },
  { import = "modules.configs.editor.tools.overseer" },
  { import = "modules.configs.editor.tools.todo-comments" },
  { import = "modules.configs.editor.tools.trouble" },
}
