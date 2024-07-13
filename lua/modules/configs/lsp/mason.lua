local icons = require("util.icons").ui
local border = require("util.icons").border.rounded

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ui = {
        border = border,
        icons = {
          package_installed = icons.CheckBold,
          package_uninstalled = icons.Ghost,
          package_pending = icons.ModifiedAlt,
        },
        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
        width = 0.7,
        height = 0.8,
      }
      opts.max_concurrent_installers = 10
    end,
    keys = {
      { "<leader>cm", false },
      { "<leader>im", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>im", group = "Mason", icon = "󰊠 " },
      },
    },
  },
}
