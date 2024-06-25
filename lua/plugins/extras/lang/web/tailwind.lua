return {
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  {
    "malbertzard/inline-fold.nvim",
    init = function()
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "*.html", "*tsx", "*.jsx" },
        callback = function(_)
          if not require("inline-fold.module").isHidden then
            vim.cmd("InlineFoldToggle")
          end
        end,
      })
    end,
    ft = "html",
    cmd = "InclineFoldToggle",
    opts = {
      defaultPlaceHolder = "…",
      queries = {
        html = {
          { pattern = 'class="([^"]*)"' },
          { pattern = 'href="(.-)"' },
          { pattern = 'src="(.-)"' },
        },
      },
    },
    keys = {
      { "<leader>uI", "<cmd>InlineFoldToggle<CR>", desc = "Toggle Inline Fold" },
    },
  },
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<leader>cT", "<cmd>TWValues<cr>", desc = "Tailwind CSS values" },
    },
    opts = {},
  },
  {
    "jacquin236/nvim-devdocs",
    optional = true,
    opts = {
      ensure_installed = { "tailwindcss" },
    },
  },
}
