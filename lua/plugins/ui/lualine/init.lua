local component = require("plugins.ui.lualine.components")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "arkav/lualine-lsp-progress" },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "",
      section_separators = "",
      globalstatus = vim.o.laststatus == 3,
      always_divide_middle = false,
      disabled_filetypes = {
        statusline = { "dashboard" },
        winbar = { "dashboard", "neo-tree", "toggleterm", "Trouble", "spectre_panel", "qf", "noice", "dbui" },
      },
    },
    sections = {
      lualine_a = { component.mode },
      lualine_b = { component.diagnostics, component.branch, component.git_dir },
      lualine_c = {
        component.filesize,
        component.diff,
        component.filename,
        component.constant,
        component.debugger,
        component.lsp_progress,
      },
      lualine_x = {
        component.search,
        component.statement,
        component.encoding,
        component.spaces,
        component.formatter,
        component.lsp_server,
      },
      lualine_y = { component.time },
      lualine_z = { component.scrollbar },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { component.spaces },
      lualine_c = { component.filename },
      lualine_x = { component.location },
      lualine_y = { component.time },
      lualine_z = { component.scrollbar },
    },
    extensions = { "lazy", "mason", "quickfix", "toggleterm", "trouble", "man", "nvim-dap-ui" },
    winbar = {
      lualine_a = {
        { "filename", separator = { left = "", right = "" }, color = { gui = "bold" } },
        { "%{%v:lua.dropbar.get_dropbar_str()%}", separator = { left = "", right = "" }, color = "nil" },
      },
    },
  },
  config = function(_, opts)
    return require("lualine").setup(opts)
  end,
}
