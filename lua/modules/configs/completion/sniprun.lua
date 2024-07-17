return {
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    cmd = {
      "SnipRun",
      "SnipInfo",
      "SnipLive",
      "SnipClose",
      "SnipReset",
      "SnipReplMemoryClean",
    },
    opts = {
      selected_interpreters = {},
      repl_enable = {
        "lua-nvim",
        "neorg",
        "orgmode",
        "python3",
        "javascript",
        "typescript",
      },
      repl_disable = {},
      interpreter_options = {
        GFM_original = {
          use_on_filetypes = { "markdown.pandoc" },
        },
        Python3_original = { error_truncate = "auto" },
      },
      display = { "NvimNotify" },
      live_display = {
        "VirtualTextOk",
        "Terminal",
      },
      display_options = {
        terminal_scrollback = vim.o.scrollback,
        terminal_line_number = false,
        terminal_signcolumn = false,
        terminal_position = "horizontal",
        terminal_persistence = true,
        terminal_width = 45,
        terminal_height = 15,
        notification_timeout = 5,
      },
      show_no_output = { "Classic", "TempFloatingWindow" },
      live_mode_toggle = "off",
      inline_messages = false,
      borders = "single",
    },
    --stylua: ignore
    keys = {
      { "<leader>cur", "<cmd>SnipRun<cr>", desc = "[sniprun] Run" },
      { "<leader>cur", function() require("sniprun").run("v") end, mode = "v", desc = "[sniprun] Run" },
      { "<leader>cui", function() require("sniprun").info() end, desc = "[sniprun] Info" },
      { "<leader>cuR", function() require("sniprun").reset() end, desc = "[sniprun] Reset" },
      { "<leader>cul", function() require("sniprun.live_mode").toggle() end, desc = "[sniprun] Live Mode" },
      { "<leader>cux", "<cmd>SnipClose<cr>", desc = "[sniprun] Clean All" },
      { "<leader>cuc", "<cmd>SnipReplMemoryClean<cr>", desc = "[sniprun] Clear Repl Memory" },

      { "<F6>", "<cmd>SnipRun<cr>", desc = "[sniprun] Run" },
      { "<F6>", function() require("sniprun").run("v") end, mode = "v", desc = "[sniprun] Run" },
      { "<S-F6>", function() require("sniprun").reset() end, desc = "[sniprun] Reset" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>cu", group = "runner", icon = "󰜎 ", mode = { "n", "v" } },
      },
    },
  },
}
