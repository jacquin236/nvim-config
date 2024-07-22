local pick = require("util.project-picker")

return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      manual_mode = true,
      show_hidden = true,
      datapath = vim.fn.stdpath("state"),
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
      { "<leader>Po", pick, desc = "Recent Projects (telescope)", remap = true },
    },
  },
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
      { "<leader>Po", pick, desc = "Recent Projects", remap = true },
    },
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    },
    opts = {
      pickers = {
        ["project.nvim#projects"] = {
          disable = false,
          sorting = "frecency",
        },
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      local projects = {
        action = pick,
        desc = " Projects",
        icon = " ",
        key = "p",
      }

      projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
      projects.key_format = "  %s"

      table.insert(opts.config.center, 1, projects)
    end,
  },
}
