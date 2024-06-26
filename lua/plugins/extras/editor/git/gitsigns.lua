local border = require("util.ui").border

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 5,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = " <author>, <author_time> · <summary>",
    preview_config = {
      border = border,
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    update_debounce = 200,
    max_file_length = 40000,
  },
  keys = {
    -- stylua: ignore
    { "<leader>uB",  "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle Line Blame" },
    { "<leader>ghe", "<cmd>Gitsigns toggle_deleted<CR>", desc = "Deletions Inline" },
  },
}
