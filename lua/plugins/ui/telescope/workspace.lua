return {
  {
    "natecraddock/workspaces.nvim",
    event = "VeryLazy",
    cmd = {
      "Telescope workspaces",
      "WorkspacesAdd",
      "WorkspacesAddDir",
      "WorkspacesRemove",
      "WorkspacesRename",
      "WorkspacesOpen",
      "WorkspacesList",
      "WorkspacesListDirs",
    },
    config = function()
      require("workspaces").setup({
        hooks = {
          open = { "Telescope find_files" },
        },
      })
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("workspaces")
      end)
    end,
    keys = {
      { "<leader>fw", "<cmd>Telescope workspaces<cr>", desc = "Workspaces" },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      local projects = {
        action = "Telescope workspaces",
        desc = " Workspaces",
        icon = require("util.icons").misc.Code .. "",
        key = "w",
      }

      projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
      projects.key_format = "  %s"

      table.insert(opts.config.center, 4, projects)
    end,
  },
}
