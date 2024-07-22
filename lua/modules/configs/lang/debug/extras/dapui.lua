local icons = require("util.icons")

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap" },
    --stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "[dapui] toggle" },
      { "<leader>dv", function() require("dapui").eval() end, desc = "[dapui] eval", mode = { "n", "v" } },
    },
    opts = {
      force_buffers = true,
      windows = { indent = 2 },
      floating = {
        border = "rounded",
        mappings = { close = { "q", "<esc>" } },
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "right",
          size = 20,
        },
        {
          elements = {
            { id = "repl", size = 0.9 },
          },
          position = "bottom",
          size = 10,
        },
      },
      mappings = {
        edit = "e",
        expand = { "<cr>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
      controls = {
        enable = true,
        icons = {
          pause = icons.dap.Pause,
          play = icons.dap.Play,
          step_into = icons.dap.StepInto,
          step_over = icons.dap.StepOver,
          step_out = icons.dap.StepOut,
          step_back = icons.dap.StepBack,
          run_last = icons.dap.RunLast,
          terminate = icons.dap.Terminate,
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
