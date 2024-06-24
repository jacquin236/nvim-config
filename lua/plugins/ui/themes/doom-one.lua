return {
    "NTBBloodbath/doom-one.nvim",
    lazy = false,
    name = "doom-one",
    config = function()
        vim.g.doom_one_cursor_coloring = true
        vim.g.doom_one_terminal_colors = true
        vim.g.doom_one_italic_comments = true
        vim.g.doom_one_enable_treesitter = true
        vim.g.doom_one_transparent_background = true
        vim.g.doom_one_pumblend_enable = true
        vim.g.doom_one_pumblend_transparency = 20
        vim.g.doom_one_plugin_neorg = true
        vim.g.doom_one_plugin_telescope = true
        vim.g.doom_one_plugin_neogit = true
        vim.g.doom_one_plugin_dashboard = true
        vim.g.doom_one_plugin_startify = true
        vim.g.doom_one_plugin_whichkey = true
        vim.g.doom_one_plugin_indent_blankline = true
        vim.g.doom_one_plugin_vim_illuminate = true
        vim.g.doom_one_plugin_lspsaga = true
    end,
}
