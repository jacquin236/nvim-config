return {
  -- Headings
  {
    "crispgm/telescope-heading.nvim",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup {
          extensions = {
            heading = {
              treesitter = true,
            },
          },
        }
        require("telescope").load_extension "heading"
      end)
    end,
    keys = {
      { "<leader>s#", "<cmd>Telescope heading<cr>", desc = "Headings" },
    },
  },
  -- File Browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup {
          extensions = {
            file_browser = {
              hijack_netrw = true,
            },
          },
        }
        require("telescope").load_extension "file_browser"
      end)
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>'", "<cmd>Telescope file_browser<cr>", desc = "File Browser (root dir)" },
      { '<leader>"', "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File Browser (cwd)" },
    },
  },
  -- Imports
  {
    "piersolenski/telescope-import.nvim",
    opts = {},
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup {
          extensions = {
            import = {
              insert_at_top = true,
            },
          },
        }
        require("telescope").load_extension "import"
      end)
    end,
    keys = {
      { "<leader>sI", "<cmd>Telescope import<CR>", desc = "Imports" },
    },
  },
  -- Lazy plugins
  {
    "tsakirist/telescope-lazy.nvim",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension "lazy"
      end)
    end,
    keys = {
      { "<leader>sP", "<cmd>Telescope lazy<CR>", desc = "Plugins (Lazy)" },
      { "<leader>lpp", "<cmd>Telescope lazy<CR>", desc = "Lazy Plugins (telescope)" },
    },
  },
  -- Snippets
  {
    "benfowler/telescope-luasnip.nvim",
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension "luasnip"
      end)
    end,
    keys = {
      { "<leader>sp", "<cmd>Telescope luasnip<CR>", desc = "Snippets (Luasnip)" },
    },
  },
  -- Undos
  {
    "debugloop/telescope-undo.nvim",
    opts = {},
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup {
          extensions = {
            undo = {
              side_by_side = true,
              layout_strategy = "vertical",
              layout_config = {
                preview_height = 0.6,
              },
            },
          },
        }
        require("telescope").load_extension "undo"
      end)
    end,
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undos" },
    },
  },
}
