-- Fix conceallevel for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("markdown_conceal", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "markdownlint-cli2", "markdown-toc", "vale" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2", "vale" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "markdownlint-cli2", "markdown-toc" },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cM",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
    init = function()
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_open_to_the_world = false
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_page_title = "${name}"
      vim.g.mkdp_browser = "/usr/bin/firefox"
    end,
  },

  { import = "modules.configs.lang.lsp.extras.markview" },
}
