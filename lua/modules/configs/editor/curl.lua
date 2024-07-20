return {
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    -- stylua: ignore
    keys = {
      { "<leader>So", function() require("curl").open_curl_tab() end, desc = "[curl] Open curl tab (cwd)" },
      { "<leader>SO", function() require("curl").open_global_tabl() end, desc = "[curl] Open curl tabl (global scope)" },
      { "<leader>Sc", function() require("curl").create_scoped_collection() end, desc = "[curl] Create/Open a collection" },
      { "<leader>SC", function() require("curl").create_global_collection() end, desc = "[curl] Create/Open global collection" },
      { "<leader>Sf", function() require("curl").pick_scoped_collection() end, desc = "[curl] Pick/Open a scoped collection" },
      { "<leader>SF", function() require("curl").pick_global_collection() end, desc = "[curl] Pick/Open a global collection" },
    },
  },
}
