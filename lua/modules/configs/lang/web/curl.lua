return {
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    -- stylua: ignore 
    keys = {
      { "<leader>Sc", function() require("curl").open_curl_tab() end, desc = "[curl] Open curl tab (cwd)" },
      { "<leader>SC", function() require("curl").open_global_tab() end, desc = "[curl] Open curl tab (global)" },
      { "<leader>So", function() require("curl").create_scoped_collection() end, desc = "[curl] Create/open a collection" },
      { "<leader>SO", function() require("curl").create_global_collection() end, desc = "[curl] Create/open global collection" },
      { "<leader>Sf", function() require("curl").pick_scoped_collection() end, desc = "[curl] Pick/open a scoped collection" },
      { "<leader>SF", function() require("curl").pick_global_collection() end, desc = "[curl] Pick/open a global collection" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      specs = {
        { "<leader>S", group = "server/client", icon = "󰖟 " },
      },
    },
  },
}
