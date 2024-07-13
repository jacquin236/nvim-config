return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>d", group = "debug", icon = " " },
      { "<leader>db", group = "breakpoints", icon = "󰙦" },

      { "<leader>di", group = "[dap] Step Into", icon = " " },
      { "<leader>do", group = "[dap] Step Out", icon = " " },
      { "<leader>dO", group = "[dap] Step Over", icon = " " },
      { "<leader>dl", group = "[dap] Run Last", icon = " " },
      { "<leader>dC", group = "[dap] Run to Cursor", icon = "" },
      { "<leader>da", group = "[dap] Run with Args", icon = " " },
      { "<leader>dw", group = "[dap] Widgets", icon = "󰜬 " },
      { "<leader>dt", group = "[dap] Terminate", icon = "󰝤 " },
      { "<leader>dc", group = "[dap] Continue", icon = " " },
      { "<leader>dp", group = "[dap] Pause", icon = "" },
      { "<leader>dj", group = "[dap] Down", icon = " " },
      { "<leader>dk", group = "[dap] Up", icon = " " },
      { "<leader>dg", group = "[dap] Goto Line (No Execute)", icon = " " },
    },
  },
}
