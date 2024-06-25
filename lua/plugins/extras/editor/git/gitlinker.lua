local function browser_open()
  return {
    action_callback = require("gitlinker.actions").open_in_browser,
  }
end

return {
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      mappings = nil,
      callbacks = {
        ["github-work"] = function(url_data)
          url_data.host = "github.com"
          return require("gitlinker.hosts").get_github_type_url(url_data)
        end,
      },
    },
    keys = {
      {
        "<leader>gku",
        function()
          require("gitlinker").get_buf_range_url("n")
        end,
        mode = "n",
        desc = "Gitlinker Copy line to clipboard",
      },
      {
        "<leader>gku",
        function()
          require("gitlinker").get_buf_range_url("v")
        end,
        mode = "v",
        desc = "Gitlinker Copy range to clipboard",
      },
      {
        "<leader>gko",
        function()
          require("gitlinker").get_repo_url(browser_open())
        end,
        desc = "Gitlinker Open in Browser",
      },
      {
        "<leader>gko",
        function()
          require("gitlinker").get_buf_range_url("n", browser_open())
        end,
        desc = "Gitlinker Open Current Line in Browser",
      },
      {
        "<leader>gko",
        function()
          require("gitlinker").get_buf_range_url("v", browser_open())
        end,
        mode = "v",
        desc = "Gitlinker Open Current Selection in Browser",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>gk"] = { name = "Gitlin[k]er" },
      },
    },
  },
}
