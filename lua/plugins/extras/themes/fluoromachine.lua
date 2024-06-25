return {
  "maxmx03/fluoromachine.nvim",
  lazy = false,
  name = "fluoromachine",
  config = function()
    require("fluoromachine").setup({
      glow = true,
      theme = "retrowave",
      transparent = vim.g.transparent_enabled,
      plugins = {
        bufferline = true,
        cmp = true,
        dashboard = true,
        editor = true,
        gitsign = true,
        hop = true,
        ibl = true,
        illuminate = true,
        lazy = true,
        minicursor = true,
        ministarter = true,
        minitabline = true,
        ministatusline = true,
        navic = true,
        neogit = true,
        neotree = true,
        noice = true,
        notify = true,
        lspconfig = true,
        syntax = true,
        telescope = true,
        treesitter = true,
        tree = true,
        wk = true,
      },
    })
  end,
}

