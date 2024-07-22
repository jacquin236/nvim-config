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
      { "<leader>pwv", function() require("package-info").show({ force = true }) end, desc = "Show Dependencies Versions" },
      { "<leader>pwV", function() require("package-info").hide() end, desc = "Hide Dependencies Versions" },
      { "<leader>pwu", function() require("package-info").update() end, desc = "Update Package" },
      { "<leader>pwr", function() require("package-info").delete() end, desc = "Remove Package" },
      { "<leader>pwc", function() require("package-info").change_version() end, desc = "Change Package Version" },
      { "<leader>pwi", function() require("package-info").install() end, desc = "Install New Dependency" },
      { "<leader>pwp", function() require("package-info").toggle() end, desc = "Toggle Package-Info" },
      { "<leader>pwt", "<cmd>Telescope package_info<cr>", desc = "Package Info" },
      -- stylua: ignore end
    },
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").setup({
          extensions = { package_info = { theme = "ivy" } },
        })
        require("telescope").load_extension("package_info")
      end)
    end,
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
