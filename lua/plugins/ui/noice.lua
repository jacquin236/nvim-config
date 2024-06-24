return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim", lazy = true },
    },
    opts = {
      debug = false,
      cmdline = {
        format = {
          IncRename = { title = "Rename" },
          substitute = { pattern = "^:%%?s/", icon = " ", ft = "regex", title = "" },
          input = { icon = " ", lang = "text", view = "cmdline_popup", title = "" },
        },
      },
      popupmenu = { backend = "nui" },
      lsp = {
        documentation = {
          opts = {
            border = { style = "rounded" },
            position = { row = 2 },
          },
        },
        progress = { enabled = false },
        signature = {
          enabled = true,
          opts = { position = { row = 2 } },
        },
        hover = { enabled = true, silent = true },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      views = {
        vsplit = { size = { width = "auto" } },
        split = { win_options = { winhighlight = { Normal = "Normal" } } },
        popup = {
          border = { style = "rounded", padding = { 0, 1 } },
        },
        cmdline_popup = {
          position = { row = 5, col = "50%" },
          size = { width = "auto", height = "auto" },
          border = { style = "rounded", padding = { 0, 1 } },
        },
        confirm = {
          border = { style = "rounded", padding = { 0, 1 }, text = { top = "" } },
        },
        popupmenu = {
          relative = "editor",
          position = { row = 9, col = "50%" },
          size = { width = 60, height = 10 },
          border = { style = "rounded", padding = { 0, 1 } },
          win_options = { winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" } },
        },
      },
      redirect = { view = "popup", filter = { event = "msg_show" } },
      routes = {
        {
          filter = {
            any = {
              { event = "msg_show", find = "^[/?]." },
            },
          },
          skip = true,
        },
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
          view = "vsplit",
          filter = { event = "msg_show", min_height = 20 },
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
          view = "mini",
          filter = {
            any = {
              { event = "msg_show", find = "^E486:" },
              { event = "notify",   max_height = 1 },
            },
          },
        },
        {
          view = "notify",
          opts = {
            title = "Warning",
            level = vim.log.levels.WARN,
            merge = false,
            replace = false,
          },
          filter = {
            any = {
              { warning = true },
              { event = "msg_show", find = "^Warn" },
              { event = "msg_show", find = "^W%d+:" },
              { event = "msg_show", find = "^No hunks$" },
            },
          },
        },
        {
          view = "notify",
          opts = {
            title = "Error",
            level = vim.log.levels.ERROR,
            merge = true,
            replace = false,
          },
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
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
      commands = { history = { view = "vsplit" } },
      presets = {
        inc_rename = true,
        long_message_to_split = true,
        lsp_doc_border = true,
        bottom_search = false,
        command_palette = true,
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })

      table.insert(opts.routes, 1, {
        filter = {
          ["not"] = {
            event = "lsp",
            kind = "progress",
          },
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
      return opts
    end,
  },
}
