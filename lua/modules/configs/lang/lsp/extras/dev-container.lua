return {
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    cmd = {
      "DevcontainerStart",
      "DevcontainerAttach",
      "DevcontainerExec",
      "DevcontainerStop",
      "DevcontainerStopAll",
      "DevcontainerRemoveAll",
      "DevcontainerLogs",
      "DevcontainerEditNearestConfig",
    },
    opts = {
      generate_commands = true,
      autocommands = {
        clean = true,
        init = true,
        update = true,
      },
      log_level = "info",
      cache_images = true,
      attach_mounts = {
        neovim_config = { enabled = true, options = {} },
        neovim_data = { enabled = true, options = {} },
        neovim_state = { enabled = true, options = {} },
      },
      compose_command = "docker-compose",
      container_runtime = "docker",
      always_mount = {},
      -- Setup for multiple `devcontainer` configs under `.devcontainer` directory
      config_search_start = function()
        if vim.g.devcontainer_selected_config == nil or vim.g.devcontainer_selected_config == "" then
          local candidates =
            vim.split(vim.fn.glob(vim.loop.cwd() .. "/.devcontainer/**/devcontainer.json"), "\n", { trimempty = true })

          if #candidates < 2 then
            vim.g.devcontainer_selected_config = vim.loop.cwd()
          else
            local choices = { "Select devcontainer config file to use: " }
            for idx, candidate in ipairs(candidates) do
              table.insert(choices, idx .. ". - " .. candidate)
            end
            local choice_idx = vim.fn.inputlist(choices)
            if choice_idx > #candidates then
              choice_idx = 1
            end
            vim.g.devcontainer_selected_config = string.gsub(candidates[choice_idx], "/devcontainer.json", "")
          end
        end
        return vim.g.devcontainer_selected_config
      end,
    },
    config = function(_, opts)
      require("devcontainer").setup(opts)
    end,
    keys = {
      { "<leader>Cs", "<cmd>DevcontainerStart<cr>", desc = "[devcontainer] Start" },
      { "<leader>Ca", "<cmd>DevcontainerAttach<cr>", desc = "[devcontainer] Attach" },
      { "<leader>Ce", "<cmd>DevcontainerExec<cr>", desc = "[devcontainer] Execute command" },
      { "<leader>Cx", "<cmd>DevcontainerStop<cr>", desc = "[devcontainer] Stop" },
      { "<leader>CX", "<cmd>DevcontainerStopAll<cr>", desc = "[devcontainer] Stop All" },
      { "<leader>Cr", "<cmd>DevcontainerRemoveAll<cr>", desc = "[devcontainer] Remove All" },
      { "<leader>Cl", "<cmd>DevcontainerLogs<cr>", desc = "[devcontainer] Open Log File" },
      {
        "<leader>cE",
        "<cmd>DevcontainerEditNearestConfig<cr>",
        desc = "[devcontainer] Open Nearest Config/Create A New One",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>C", group = "container", icon = "󰨾 " },
      },
    },
  },
}
