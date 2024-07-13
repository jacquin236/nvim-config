return {
  {
    "lewis6991/hover.nvim",
    init = function()
      -- Require providers
      require("hover.providers.lsp")
      -- require('hover.providers.gh')
      -- require('hover.providers.gh_user')
      -- require('hover.providers.jira')
      require("hover.providers.dap")
      -- require('hover.providers.fold_preview')
      require("hover.providers.diagnostic")
      -- require('hover.providers.man')
      require("hover.providers.dictionary")
    end,
    opts = {
      preview_opts = { border = require("util.icons").border.rounded },
      preview_window = false,
      title = true,
      mouse_providers = { "LSP" },
      mouse_delay = 500,
    },
    config = function(_, opts)
      require("hover").setup(opts)

      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "gx", require("hover").hover_select, { desc = "[hover.nvim] select" })
      vim.keymap.set("n", "<C-p>", function()
        require("hover").hover_switch("previous")
      end, { desc = "[hover.nvim] previous source" })
      vim.keymap.set("n", "<C-n>", function()
        require("hover").hover_switch("next")
      end, { desc = "[hover.nvim] next source" })

      -- Mouse support
      vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "[hover.nvim] mouse" })
      vim.o.mousemoveevent = true
    end,
  },
}
