local border = require("util.ui").border

return {
  "jacquin236/nvim-devdocs",
  dev = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "DevdocsFetch",
    "DevdocsInstall",
    "DevdocsUninstall",
    "DevdocsOpen",
    "DevdocsOpenFloat",
    "DevdocsOpenCurrent",
    "DevdocsOpenCurrentFloat",
    "DevdocsUpdate",
    "DevdocsUpdateAll",
  },
  keys = {
    { "<leader>sE", "<cmd>DevdocsOpen<cr>", desc = "Devdocs" },
    { "<leader>se", "<cmd>DevdocsOpenCurrent<cr>", desc = "Devdocs Current" },
  },
  opts = {
    dir_path = vim.fn.stdpath("data") .. "/devdocs",
    telescope = {},
    float_win = {
      relative = "editor",
      height = 25,
      width = 100,
      border = border,
    },
    wrap = false,
    previewer_cmd = "glow",
    cmd_args = { "-s", "dark", "-w", "80" },
    cmd_ignore = {},
    picker_cmd = false,
    picker_cmd_args = {},
    after_open = function(bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":close<cr>", {})
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<esc>", ":close<cr>", {})
    end,
    ensure_installed = {
      "lua-5.4",
      "git",
      "npm",
      "node",
      "javascript",
    },
  },
}
