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
      always_divide_middle = true,
      disabled_filetypes = {
        statusline = { "dashboard" },
        winbar = { "dashboard", "neo-tree" },
      },
    },
    sections = {
      lualine_a = { component.mode },
      lualine_b = { component.diagnostics },
      lualine_c = {
        component.branch,
        component.filesize,
        component.git_dir,
        component.diff,
        component.filename,
        component.constant,
      },
      lualine_x = {
        component.lsp_progress,
        component.search,
        component.statement,
        component.debugger,
        component.encoding,
        component.spaces,
        component.formatter,
        component.lsp_server,
      },
      lualine_y = { component.location, component.time },
      lualine_z = { component.progress },
    },
    extensions = { "lazy" },
    winbar = {
      lualine_a = {
        { "filename", separator = { left = "", right = "" } },
        { "%{%v:lua.dropbar.get_dropbar_str()%}", separator = { left = "", right = "" }, color = "nil" },
      },
    },
  },
  config = function(_, opts)
    return require("lualine").setup(opts)
  end,
}
