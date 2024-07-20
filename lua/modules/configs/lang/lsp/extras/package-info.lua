return {
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = {
      "BufRead package.json",
      "BufRead package-lock.json",
    },
    keys = {
      -- stylua: ignore start
      { "<leader>pwv", function() require("package-info").show({ force = true }) end, desc = "Package Versions" },
      { "<leader>pwu", function() require("package-info").update() end, desc = "Update Package" },
      { "<leader>pwr", function() require("package-info").delete() end, desc = "Remove Package" },
      { "<leader>pwc", function() require("package-info").change_version() end, desc = "Change Package Version" },
      { "<leader>pwi", function() require("package-info").install() end, desc = "Install New Dependency" },
      { "<leader>pwt", "<cmd>Telescope package_info<cr>", desc = "Package Info" },
      -- stylua: ignore end
    },
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup({
          extensions = { package_info = { theme = "ivy" } },
        })
        require("telescope").load_extension("package")
      end)
    end,
  },
  {
    "voldikss/vim-floaterm",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>pwp", "<cmd>FloatermNew --disposable --name=lazynpm --opener=edit --titleposition=center --height=0.85 --width=0.85 --cwd=<root> lazynpm<CR>", desc = "Lazynpm" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>p", group = "packages/dependencies", icon = " ", mode = { "n", "v" } },
        { "<leader>pw", name = "web: package.json", icon = "🧰" },
      },
    },
  },
}
