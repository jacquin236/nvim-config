---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

local icons = require "util.icons"

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text", opts = { all_frames = true } },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "[dap] Breakpoint Condition" },
      { "<leader>dc", function() require("dap").continue() end, desc = "[dap] Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "[dap] Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "[dap] Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "[dap] Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "[dap] Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "[dap] Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "[dap] Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "[dap] Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "[dap] Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "[dap] Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "[dap] Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "[dap] Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "[dap] Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "[dap] Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "[dap] Widgets" },

      { "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step out" },
      { "<S-F2>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    },
    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has "mason-nvim-dap.nvim" then
        require("mason-nvim-dap").setup(LazyVim.opts "mason-nvim-dap.nvim")
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require "dap.ext.vscode"
      local json = require "plenary.json"
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
}
