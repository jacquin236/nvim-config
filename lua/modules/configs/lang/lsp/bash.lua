vim.filetype.add({
  pattern = {
    [".*/kitty/.+%.conf"] = "bash",
    ["^.env%..*"] = "bash",
    ["%.env%.[%w_.-]+"] = "sh",
  },
})

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "bash-language-server", "shellcheck", "efm" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "bash" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "zsh", "bash" },
          settings = {
            bashIde = {
              globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
            },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.bash = opts.linters_by_ft.bash or {}
      table.insert(opts.linters_by_ft.bash, "shellcheck")
      return opts
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local function add_formatters(tbl)
        for ft, formatters in pairs(tbl) do
          if opts.formatters_by_ft[ft] == nil then
            opts.formatters_by_ft[ft] = formatters
          else
            vim.list_extend(opts.formatters_by_ft[ft], formatters)
          end
        end
      end

      add_formatters({
        ["sh"] = { "shfmt" },
        ["bash"] = { "shfmt" },
        ["zsh"] = { "shfmt" },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "shfmt" },
    },
  },
}
