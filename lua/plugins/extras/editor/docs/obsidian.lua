return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open on App" },
      { "<leader>og", "<cmd>ObsidianSearch<CR>", desc = "Grep" },
      { "<leader>sO", "<cmd>ObsidianSearch<CR>", desc = "Obsidian Grep" },
      { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note" },
      { "<leader>o<space>", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find Files" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
      { "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Tags" },
      { "<leader>oT", "<cmd>ObsidianTemplate<CR>", desc = "Template" },
      { "<leader>ol", "<cmd>ObsidianLink<CR>", desc = "Link" },
      { "<leader>oL", "<cmd>ObsidianLinks<CR>", desc = "Links" },
      { "<leader>oN", "<cmd>ObsidianLinkNew<CR>", desc = "New Link" },
      { "<leader>oe", "<cmd>ObsidianExtractNote<CR>", desc = "Extract Note" },
      { "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "Workspace" },
      { "<leader>or", "<cmd>ObsidianRename<CR>", desc = "Rename" },
      { "<leader>oi", "<cmd>ObsidianPasteImg<CR>", desc = "Paste Image" },
      { "<leader>od", "<cmd>ObsidianDailies<CR>", desc = "Daily Notes" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Documents/Obsidian/Notes",
        },
      },

      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<C-c>"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },

      templates = {
        subdir = "_data_/templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>o"] = { name = " Obsidian" },
      },
    },
  },
}
