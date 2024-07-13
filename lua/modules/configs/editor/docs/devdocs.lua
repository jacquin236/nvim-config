return {
  {
    "jacquin236/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    dev = true,
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
    opts = {
      dir_path = vim.fn.stdpath("data") .. "/devdocs",
      telescope = {},
      float_win = {
        height = 25,
        width = 100,
        border = "rounded",
      },
      wrap = true,
      previewer_cmd = nil, -- for example: "glow"
      cmd_args = {}, -- example using glow: { "-s", "dark", "-w", "80" }
      cmd_ignore = {}, -- ignore cmd rendering for the listed docs
      picker_cmd = false, -- use cmd previewer in picker preview
      picker_cmd_args = {}, -- example using glow: { "-s", "dark", "-w", "50" }
      after_open = function(bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":close<CR>", {})
      end,
      ensure_installed = {
        "javascript",
        "lua-5.4",
        "git",
        "npm",
        "node",
      },
    },
    keys = {
      { "<leader>odd", "<cmd>DevdocsOpen<cr>", desc = "[devdocs] open" },
      { "<leader>odc", "<cmd>DevdocsOpenCurrent<cr>", desc = "[devdocs] current" },
      { "<leader>odf", "<cmd>DevsdocsFetch<cr>", desc = "[devdocs] fetch" },
      { "<leader>odu", "<cmd>DevsdocsUpdateAll<cr>", desc = "[devdocs] update all" },
    },
  },
}
