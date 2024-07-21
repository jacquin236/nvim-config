return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerBuild",
      "OverseerClearCache",
      "OverseerDebugParser",
      "OverseerDeleteBundle",
      "OverseerInfo",
      "OverseerLoadBundle",
      "OverseerQuickAction",
      "OverseerRun",
      "OverseerRunCmd",
      "OverseerSaveBundle",
      "OverseerTaskAction",
      "OverseerTestOutput",
      "OverseerToggle",
      "Make",
      "Grep",
    },
    keys = {
      { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "[overseer] Task Builder" },
      { "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "[overseer] Clear cache" },
      { "<leader>od", "<cmd>OverseerDebugParser<cr>", desc = "[overseer] Debug parser" },
      { "<leader>oD", "<cmd>OverseerDeleteBundle<cr>", desc = "[overseer] Delete bundle" },
      { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "[overseer] Info" },
      { "<leader>ol", "<cmd>OverseerLoadBundle<cr>", desc = "[overseer] Load bundle" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "[overseer] Quick action" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "[overseer] Run task" },
      { "<leader>oR", "<cmd>OverseerRunCmd<cr>", desc = "[overseer] Run command" },
      { "<leader>os", "<cmd>OverseerSaveBundle<cr>", desc = "[overseer] Save bundle" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "[overseer] Task action" },
      { "<leader>oT", "<cmd>OverseerTestOutput<cr>", desc = "[overseer] Test output" },
      { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "[overseer] Toggle task list" },

      { "<leader>om", "<cmd>Make<cr>", desc = "[overseer] Run makeprg as Overseer Task" },
      { "<leader>og", "<cmd>Grep<cr>", desc = "[overseer] Run grepprg as Overseer Task" },
      { "<leader>io", "<cmd>OverseerInfo<cr>", desc = "Overseer", remap = true },
    },
    opts = {
      dap = false,
      templates = { builtin = true },
      strategy = { "jobstart", preserve_output = true, use_terminal = true },
      task_list = {
        bindings = {
          ["<C-h>"] = false,
          ["<C-j>"] = false,
          ["<C-k>"] = false,
          ["<C-l>"] = false,
          ["<C-s>"] = false,
          ["<C-x>"] = "OpenSplit",
          ["<C-r>"] = "<cmd>OverseerQuickAction restart<cr>",
          ["<C-d>"] = "<cmd>OverseerQuickAction dispose<cr>",
          ["dd"] = "Dispose",
        },
        direction = "bottom",
      },
      form = {
        win_opts = { winblend = 0 },
      },
      confirm = {
        win_opts = { winblend = 0 },
      },
      task_win = {
        win_opts = { winblend = 0 },
        padding = 1,
      },
      log = {
        {
          type = "echo",
          level = vim.log.levels.INFO,
        },
        {
          type = "file",
          filename = "overseer.log",
          level = vim.log.levels.DEBUG,
        },
      },
      component_aliases = {
        default = {
          { "display_duration", detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          { "on_complete_notify", system = "unfocused" },
          { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
        },
        default_neotest = {
          "unique",
          { "on_complete_notify", system = "unfocused", on_change = true },
          "default",
        },
      },
      post_setup = {},
    },
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      opts.templates = vim.tbl_keys(opts.templates)
      for _, cb in pairs(opts.post_setup) do
        cb()
      end

      local create_command = vim.api.nvim_create_user_command

      create_command("OverseerDebugParser", 'lua require("overseer").debug_parser()', {})

      create_command("OverseerTestOutput", function(params)
        vim.cmd.tabnew()
        vim.bo.bufhidden = "wipe"
        local TaskView = require("overseer.task_view")
        TaskView.new(0, {
          select = function(self, tasks)
            for _, task in ipairs(tasks) do
              if task.metadata.neotest_group_id then
                return task
              end
            end
            self:dispose()
          end,
        })
      end, {})

      create_command("Make", function(params)
        -- Insert args at the '$*' in the makeprg
        local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
        if num_subs == 0 then
          cmd = cmd .. " " .. params.args
        end
        local task = require("overseer").new_task({
          cmd = vim.fn.expandcmd(cmd),
          components = {
            { "on_output_quickfix", open = not params.bang, open_height = 8 },
            "unique",
            "default",
          },
        })
        task:start()
      end, {
        desc = "Run your makeprg as Overseer Task",
        nargs = "*",
        bang = true,
      })

      create_command("Grep", function(params)
        local args = vim.fn.expandcmd(params.args)
        -- Insert args at the '$*' in the grepprg
        local cmd, num_subs = vim.o.grepprg:gsub("%$%*", args)
        if num_subs == 0 then
          cmd = cmd .. " " .. args
        end

        local cwd
        local task = overseer.new_task({
          cmd = cmd,
          cwd = cwd,
          name = "grep " .. args,
          components = {
            {
              "on_output_quickfix",
              errorformat = vim.o.grepformat,
              open = not params.bang,
              open_height = 8,
              items_only = true,
            },
            -- We don't care to keep this around as long as most tasks
            { "on_complete_dispose", timeout = 30, require_view = {} },
            "default",
          },
        })
        task:start()
      end, {
        nargs = "*",
        bang = true,
        bar = true,
        complete = "file",
      })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>o", group = "overseer", icon = "󰚔 " },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      opts = opts or {}
      opts.consumers = opts.consumers or {}
      opts.consumers.overseer = require("neotest.consumers.overseer")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      require("overseer").enable_dap()
    end,
  },
  {
    "catppuccin",
    optional = true,
    opts = {
      integrations = { overseer = true },
    },
  },
}
