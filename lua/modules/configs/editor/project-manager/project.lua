local pick = require("util.project-picker")

return {
  {
    "ahmedkhalf/project.nvim",
    opts = {},
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
      { "<leader>Pp", pick, desc = "[project] search for projects", remap = true },
    },
  },
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
      { "<leader>Pp", pick, desc = "[project] search for projects", remap = true },
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

      table.insert(opts.config.center, 3, projects)
    end,
  },
}
