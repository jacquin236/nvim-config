return {
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
    cmd = { "JqxList", "JaxQuery" },
    init = function()
      local jqx = require("nvim-jqx.config")
      jqx.geometry.border = "single"
      jqx.sort = true
      jqx.show_legend = true
      jqx.use_quickfix = false
    end,
    keys = {
      { "<leader>cj", ft = { "json", "yaml" }, "<cmd>JqxList<cr>", desc = "Jqx List" },
      { "<leader>cJ", ft = { "json", "yaml" }, "<cmd>JqxQuery<cr>", desc = "Jqx Query" },
    },
  },
}
