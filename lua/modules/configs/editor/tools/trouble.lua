return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      auto_close = true,
      focus = true,
      keys = {
        e = "jump",
        l = "fold_open",
        L = "fold_open_recursive",
        h = "fold_close",
        H = "fold_close_recursive",
      },
      ---@type trouble.Indent.symbols
      icons = {
        indent = {
          top = "│ ",
          middle = "├╴",
          last = "╰╴",
          fold_open = " ",
          fold_closed = " ",
          ws = "  ",
        },
      },
      ---@type table<string, trouble.Mode>
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        },
        test = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "[trouble] Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[trouble] Buffer Diagnostic" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "[trouble] symbols" },
      {
        "<leader>xS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "[trouble] LSP Ref/Def",
      },
      { "<leader>xL", false },
      { "<leader>xQ", false },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "[trouble] Location List" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "[trouble] Quickfix List" },
      { "<leader>cs", false },
      { "<leader>cS", false },
    },
  },
}
