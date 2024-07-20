return {
  -- Treesitter
  -- Instead of importing the whole directory of `extras`, I separated each file for better maintained
  { import = "modules.configs.coding.treesitter.extras.auto-indent" },
  { import = "modules.configs.coding.treesitter.extras.endwise" },
  { import = "modules.configs.coding.treesitter.extras.indent-blankline" },
  { import = "modules.configs.coding.treesitter.extras.rainbow-delimiters" },
  { import = "modules.configs.coding.treesitter.extras.text-case" },
  { import = "modules.configs.coding.treesitter.extras.various-textobjects" },
  { import = "modules.configs.coding.treesitter.extras.vim-matchup" },
  { import = "modules.configs.coding.treesitter.core" },

  -- Completion
  -- cmp config
  { import = "modules.configs.coding.completion.core" },
  { import = "modules.configs.coding.completion.extras.cmp-dotenv" },
  { import = "modules.configs.coding.completion.extras.cmp-emoji" },
  { import = "modules.configs.coding.completion.extras.cmp-nerdfont" },
  { import = "modules.configs.coding.completion.extras.cmp-npm" },

  -- annotations
  { import = "modules.configs.coding.annotations.comment-box" },
  { import = "modules.configs.coding.annotations.dooku" },
  { import = "modules.configs.coding.annotations.nvim-scissors" },
}
