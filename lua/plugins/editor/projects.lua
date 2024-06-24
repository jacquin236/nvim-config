return {
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
    },
    cmd = "Nerdy",
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },
      patterns = {
        ".git",
        "package.json",
        "Makefile",
        "=nvim-projects",
        "=projects",
        "=.config",
      },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      keys = {
        { "<leader>fp", "<cmd>Telescope projects<cr>", mode = "n", desc = "Projects" },
      },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local projects = {
        action = function()
          if LazyVim.pick.picker.name == "telescope" then
            return vim.cmd("Telescope projects")
          else
            return
          end
        end,
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
