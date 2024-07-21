return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {},
      status = { enabled = true },
      output = {
        enabled = true,
        open_on_run = false,
      },
      quickfix = {
        open = function()
          if LazyVim.has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
      discovery = { enabled = false, concurrent = 1 },
      diagnostic = { enabled = true },
      floating = { border = require("util.icons").border.rounded },
      running = { concurrent = true },
      summary = {
        animated = true,
        mappings = {
          attach = "a",
          expand = "l",
          expand_all = "L",
          jumpto = "gf",
          output = "o",
          run = "<C-r>",
          short = "p",
          stop = "u",
        },
      },
      icons = {
        passed = " ",
        running = " ",
        failed = " ",
        unknown = " ",
        running_animated = vim.tbl_map(function(s)
          return s .. " "
        end, { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }),
      },
    },
    config = function(_, opts)
      local namespace_neotest = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, namespace_neotest)

      if LazyVim.has("trouble.nvim") then
        opts.consumers = opts.consumers or {}
        ---@type neotest.Consumer
        opts.consumers.trouble = function(client)
          client.listeners.results = function(adapter_id, results, partial)
            if partial then
              return
            end
            local tree = assert(client:get_position(nil, { adapter = adapter_id }))

            local failed = 0
            for pos_id, result in pairs(results) do
              if result.status == "failed" and tree:get_key(pos_id) then
                failed = failed + 1
              end
            end
            vim.schedule(function()
              local trouble = require("trouble")
              if trouble.is_open() then
                trouble.refresh()
                if failed == 0 then
                  trouble.close()
                end
              end
            end)
            return {}
          end
        end
      end

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
    },
  },
  {
    "nvim-neotest/neotest",
    -- stylua: ignore
    keys = {
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "[test] Attach" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[test] Run Test File" },
      { "<leader>tF", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[test] Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "[test] Run Nearest Test" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "[test] Run Last Test" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[test] Toggle Test Summary" },
      { "<leader>tS", function() require("neotest").run.run({ suite = true }) end, desc = "[test] Suite" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[test] Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[test] Toggle Output Panel" },
      { "<leader>tt", function() require("neotest").run.stop() end, desc = "[test] Terminate" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "[test] Toggle Watch" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>t", group = "test", icon = "󰂖" },
      },
    },
  },
}
