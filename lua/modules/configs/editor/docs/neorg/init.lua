local aug = vim.api.nvim_create_augroup("NorgAugroup", { clear = true })

return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    version = false,
    dependencies = {
      "luarocks.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-cmp",
      "mason.nvim",
      "plenary.nvim",
      "laher/neorg-exec",
      { "nvim-neorg/neorg-telescope", dependencies = "nvim-telescope/telescope.nvim" },
      { "pysan3/neorg-templates", dependencies = "L3MON4D3/LuaSnip" },
    },
    cmd = "Neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.concealer"] = {
            config = {
              icon_preset = "basic",
              icons = {
                code_block = { spell_check = false },
              },
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.defaults"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes/neorg",
                projects = "~/projects/notes/neorg",
              },
              default_workspace = "notes",
            },
          },
          ["core.esupports.hop"] = {},
          ["core.export"] = {},
          ["core.export.markdown"] = {},
          ["core.integrations.nvim-cmp"] = {},
          ["core.integrations.telescope"] = {
            config = {
              insert_file_link = {
                show_title_preview = true,
              },
            },
          },
          ["core.integrations.treesitter"] = {},
          ["core.journal"] = {
            config = {
              strategy = "nested",
            },
          },
          ["core.keybinds"] = {
            config = {
              default_keybinds = true,
            },
          },
          ["core.looking-glass"] = {},
          ["core.tangle"] = {
            config = {
              report_on_empty = false,
            },
          },
          ["external.exec"] = {},
          ["external.templates"] = {
            templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
            keywords = require("modules.configs.editor.docs.neorg.templates"),
          },
        },
      })
    end,
    init = function()
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = aug,
        pattern = "norg",
        command = "Neorg tangle current-file",
      })
    end,
    keys = require("modules.configs.editor.docs.neorg.mappings"),
  },
}
