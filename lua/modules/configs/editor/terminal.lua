local map = vim.keymap.set
local border = require("util.icons").border.rounded

return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    cmd = {
      "ToggleTerm",
      "ToggleTermSetName",
      "ToggleTermToggleAll",
      "ToggleTermSendVisualLines",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualSelection",
    },
    opts = {
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      direction = "horizontal",
      autochdir = true,
      persist_mode = true,
      persist_size = true,
      insert_mappings = false,
      start_in_insert = true,
      close_on_exit = true,
      shell = vim.o.shell,
      winbar = { enabled = true },
      highlights = {
        FloatBorder = { link = "FloatBorder" },
        NormalFloat = { link = "NormalFloat" },
      },
      float_opts = {
        border = border,
        winblend = 3,
        highlights = { border = "Normal", background = "Normal" },
      },
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      local float_handler = function(term)
        vim.keymap.del("t", "jk", { buffer = term.bufnr })
        vim.keymap.del("t", "<esc>", { buffer = term.bufnr })
      end

      local Terminal = require("toggleterm.terminal").Terminal

      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        hidden = true,
        direction = "float",
        on_open = float_handler,
      })

      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        dir = "git_dir",
        hidden = true,
        direction = "float",
        on_open = float_handler,
      })

      local gh_dash = Terminal:new({
        cmd = "gh dash",
        hidden = true,
        direction = "float",
        on_open = float_handler,
        float_opts = {
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
          width = function()
            return math.floor(vim.o.columns * 0.95)
          end,
        },
      })

      map("n", "<localleader>th", function()
        gh_dash:toggle()
      end, { desc = "ToggleTerm: Toggle GitHub Dashboard" })
      map("n", "<localleader>tg", function()
        lazygit:toggle()
      end, { desc = "ToggleTerm: Toggle lazygit" })
      map("n", "<localleader>td", function()
        lazydocker:toggle()
      end, { desc = "ToggleTerm: Toggle lazydocker" })
    end,
    keys = {
      { [[<c-\>]], "<cmd>ToggleTerm<cr>", mode = "n", desc = "Toggle Terminal (toggleterm)" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<localleader>t", group = "Terminal", icon = " " },
      },
    },
  },
}
