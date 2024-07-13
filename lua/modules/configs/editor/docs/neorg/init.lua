local norg_setup = require("modules.configs.editor.docs.neorg.commands")
local open_index_in_popup = require("modules.configs.editor.docs.neorg.popups")
local function augroup(name)
  return vim.api.nvim_create_augroup("docs" .. name, { clear = true })
end

return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    ft = "norg",
    version = "*",
    cmd = "Neorg",
    dependencies = {
      "luarocks.nvim",
      "nvim-cmp",
      "mason.nvim",
      "plenary.nvim",
      "nvim-neorg/neorg-telescope",
      "laher/neorg-exec",
      "phenax/neorg-hop-extras",
      { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
    },
    init = function()
      norg_setup({})
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup("neorg"),
        pattern = "*.norg",
        command = "Neorg tangle current-file",
      })
    end,
    opts = {
      load = {
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.concealer"] = {},
        ["core.defaults"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              proj_notes = "~/projects/notes/neorg",
              notes = "~/notes/neorg",
            },
            default_workspace = "notes",
          },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.integrations.telescope"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.journal"] = {},
        ["core.keybinds"] = {
          config = {
            default_keybinds = true,
            hook = require("modules.configs.editor.docs.neorg.keybinds").hook,
          },
        },
        ["core.looking-glass"] = {},
        ["core.summary"] = {},
        ["core.syntax"] = {},
        ["external.exec"] = {},
        ["external.hop-extras"] = {},
        ["external.templates"] = {
          config = {
            templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
            keywords = require("modules.configs.editor.docs.neorg.templates"),
          },
        },
      },
    },
    config = function(_, opts)
      require("neorg").setup(opts)
    end,
    keys = {
      { "<leader>onn", "<cmd>Neorg<cr>", desc = "[neorg] Toggle" },
      { "<leader>oni", "<cmd>Neorg index<cr>", desc = "[neorg] Index" },
      { "<leader>onp", open_index_in_popup, desc = "[neorg] Open Index in Popup" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "neorg" })
    end,
  },
}
