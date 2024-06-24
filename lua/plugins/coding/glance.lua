local icons = require("util.icons")

return {
  {
    "dnlhc/glance.nvim",
    lazy = true,
    opts = {
      height = 20,
      zindex = 50,
      preview_win_opts = {
        relativenumber = false,
        wrap = true,
        number = true,
        cursorline = true,
      },
      theme = { enable = true, mode = "darken" },
      border = {
        enable = true,
        top_char = "―",
        bottom_char = "―",
      },
      folds = {
        folded = true,
        fold_closed = icons.ui.ChevronShortRight,
        fold_open = icons.ui.ChevronShortDown,
      },
      indent_lines = { enable = true },
      winbar = { enable = true },
      hooks = {
        before_open = function(results, open, _, method)
          if #results == 0 then
            vim.notify(
              "This method is not supported by any of the servers registered for the current buffer",
              vim.log.levels.WARN,
              { title = "Glance" }
            )
          elseif #results == 1 and method == "references" then
            vim.notify("The identifier under cursor is the only one found", vim.log.levels.INFO, { title = "Glance" })
          else
            open(results)
          end
        end,
      },
    },
    keys = {
      { "Gd", "<cmd>Glance definitions<cr>", mode = "n", desc = "Lsp: Glance Definitions" },
      { "Gr", "<cmd>Glance references<cr>", mode = "n", desc = "Lsp: Glance References" },
      { "Gy", "<cmd>Glance type_definitions<cr>", mode = "n", desc = "Lsp: Glance Type Definitions" },
      { "Gm", "<cmd>Glance implementations<cr>", mode = "n", desc = "Lsp: Glance implementations" },
    },
    config = function(_, opts)
      require("glance").setup(opts)
    end,
  },
}
