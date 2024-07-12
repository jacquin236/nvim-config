return {
  "mfussenegger/nvim-dap",
  optional = true,
  vscode = false,
  dependencies = {
    {
      "Weissle/persistent-breakpoints.nvim",
      vscode = false,
      event = "LazyFile",
      keys = {
        { "<leader>dbd", "<cmd>PBClearAllBreakpoints<cr>", desc = "[breakpoints] Delete All Breakpoints" },
        { "<leader>dbc", "<cmd>PBSetConditionalBreakpoint<cr>", desc = "[breakpoints] Breakpoint Condition" },
        { "<leader>dbb", "<cmd>PBToggleBreakpoint<cr>", desc = "[breakpoints] Toggle Breakpoint" },
      },
      opts = { load_breakpoints_event = { "BufReadPost" } },
    },
  },
}
