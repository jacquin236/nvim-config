local border = require("util.icons").border.rounded

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = true, silent = true },
        signature = {
          enabled = true,
          auto_open = { enabled = true },
          opts = { position = { row = 2 } },
        },
        documentation = {
          opts = {
            border = { style = border },
            position = { row = 2 },
          },
        },
      },
      cmdline = {
        format = {
          IncRename = { title = " Rename " },
          substitute = { pattern = "^:%%?s/", icon = " ", ft = "regex", title = "" },
          input = { icon = " ", lang = "text", view = "cmdline_popup", title = "" },
        },
      },
      popupmenu = { backend = "nui" },
      views = {
        vsplit = { size = { width = "auto" } },
        split = { win_options = { winhighlight = { Normal = "Normal" } } },
        popup = {
          border = { style = border, padding = { 0, 1 } },
        },
        cmdline_popup = {
          position = { row = 5, col = "50%" },
          size = { width = "auto", height = "auto" },
          border = { style = border, padding = { 0, 1 } },
        },
        confirm = {
          border = { style = border, padding = { 0, 1 }, text = { top = "" } },
        },
        popupmenu = {
          relative = "editor",
          position = { row = 9, col = "50%" },
          size = { width = 60, height = 10 },
          border = { style = border, padding = { 0, 1 } },
          win_options = { winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" } },
        },
      },
      redirect = { view = "popup", filter = { event = "msg_show" } },
      routes = {
        {
          opts = { skip = true },
          filter = {
            any = {
              { event = "msg_show", find = "written" },
              { event = "msg_show", find = "%d+ lines, %d+ bytes" },
              { event = "msg_show", kind = "search_count" },
              { event = "msg_show", find = "%d+L, %d+B" },
              { event = "msg_show", find = "^Hunk %d+ of %d" },
              { event = "msg_show", find = "%d+ change" },
              { event = "msg_show", find = "%d+ line" },
              { event = "msg_show", find = "%d+ more line" },
            },
          },
        },
        {
          view = "notify",
          filter = {
            any = {
              { event = "msg_show", min_height = 10 },
              { event = "msg_show", find = "Treesitter" },
            },
          },
          opts = { timeout = 10000 },
        },
        {
          view = "notify",
          filter = {
            any = {
              { event = "msg_show", find = "^E486:" },
              { event = "notify", max_height = 1 },
            },
          },
        },
        {
          view = "notify",
          filter = {
            any = {
              { warning = true },
              { event = "msg_show", find = "^Warn" },
              { event = "msg_show", find = "^W%d+:" },
              { event = "msg_show", find = "^No hunks$" },
            },
          },
          opts = { title = "Warning", level = vim.log.levels.WARN, merge = false, replace = false },
        },
        {
          view = "notify",
          opts = { title = "Error", level = vim.log.levels.ERROR, merge = true, replace = false },
          filter = {
            any = {
              { error = true },
              { event = "msg_show", find = "^Error" },
              { event = "msg_show", find = "^E%d+:" },
            },
          },
        },
        {
          view = "notify",
          opts = { title = "" },
          filter = { kind = { "emsg", "echo", "echomsg" } },
        },
      },
      commands = { history = { view = "vsplit" } },
      presets = {
        inc_rename = true,
        long_message_to_split = true,
        lsp_doc_border = true,
        bottom_search = false,
        command_palette = false,
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
    end,
    keys = {
      -- stylua: ignore start
      { "<leader>sn", false },
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
      -- stylua: ignore end
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>sn", group = "noice", icon = " " },
      },
    },
  },
}
