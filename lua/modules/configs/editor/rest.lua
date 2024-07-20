vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http" },
    -- stylua: ignore 
    keys = {
      { "<leader>Sr", function() require("kulala").run() end, desc = "[rest] Send Request" },
      { "<leader>St", function() require("kulala").toggle_view() end, desc = "[rest] Toggle headers/body" },
      { "<leader>Sp", function() require("kulala").jump_prev() end, desc = "[rest] Jump to previous request" },
      { "<leader>Sn", function() require("kulala").jump_next() end, desc = "[rest] Jump to next request" },
    },
    opts = {
      formatters = {
        json = { "jq", "." },
        xml = { "xmllint", "--format", "-" },
        html = { "xmllint", "--format", "--html", "-" },
      },
      icons = {
        inlay = {
          loading = "⏳",
          done = "😎",
          error = "😱",
        },
        lualine = "🐼",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "http", "graphql" } },
  },
}
