return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "annotations/snippets", icon = " " },
        -- neogen
        { "<leader>aC", group = "[neogen] class", icon = "󰠱" },
        { "<leader>af", group = "[neogen] function", icon = "󰊕" },
        { "<leader>at", group = "[neogen] type", icon = "" },
        { "<leader>aF", group = "[neogen] file", icon = "󰈙" },
        { "<leader>an", group = "[neogen] default annotations", icon = "󰙆 " },
        -- scissors
        { "<leader>ae", group = "[scissors] edit snippets", icon = "󱇧" },
        { "<leader>aa", group = "[scissors] add snippets", icon = " " },
        -- dooku
        { "<leader>ag", group = "[dooku] generate HTML docs", icon = "" },
        { "<leader>ao", group = "[dooku] open HTML docs", icon = "" },
        -- comment-box
        { "<leader>ac", group = "comments", icon = " " },
        { "<leader>acc", group = "[comment-box] catalog", icon = " " },
        { "<leader>acb", group = "[comment-box] box title", icon = "󰑕" },
        { "<leader>acl", group = "[comment-box] simple line", icon = "󰈚" },
        { "<leader>act", group = "[comment-dox] titled line", icon = "󰗴" },
        { "<leader>acm", group = "[comment-box] marked", icon = "󰍕 " },
        { "<leader>acd", group = "[comment-box] delete comment style", icon = "󰗩 " },
      },
    },
  },
}
