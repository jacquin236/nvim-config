return {
  {
    "LudoPinelli/comment-box.nvim",
    opts = {
      comment_style = "auto",
    },
    keys = {
      { "<leader>acb", "<cmd>CBccbox<cr>", desc = "[comment-box] box title" },
      { "<leader>acc", "<cmd>CBcatalog<cr>", desc = "[comment-box] catalog" },
      { "<leader>acl", "<cmd>CBline<cr>", desc = "[comment-box] simple line" },
      { "<leader>act", "<cmd>CBllline<cr>", desc = "[comment-box] titled line" },
      { "<leader>acm", "<cmd>CBllbox14<cr>", desc = "[comment-box] marked" },
      { "<leader>acd", "<cmd>CBd<cr>", desc = "[comment-box] delete comment style" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "annotations/snippets", icon = " " },
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
