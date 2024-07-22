return {
  {
    "LudoPinelli/comment-box.nvim",
    opts = {},
    config = function(_, opts)
      require("comment-box").setup(opts)
    end,
    -- stylua: ignore 
    keys = {
      -- Boxes
      { "<leader>abll", "<cmd>CBllbox<cr>", desc = "Left Box Left Text", mode = { "n", "v" } },
      { "<leader>ablc", "<cmd>CBlcbox<cr>", desc = "Left Box Center Text", mode = { "n", "v" } },
      { "<leader>ablr", "<cmd>CBlrbox<cr>", desc = "Left Box Right Text", mode = { "n", "v" } },
      { "<leader>abcl", "<cmd>CBclbox<cr>", desc = "Center Box Left Text", mode = { "n", "v" } },
      { "<leader>abcc", "<cmd>CBccbox<cr>", desc = "Center Box Center Text", mode = { "n", "v" } },
      { "<leader>abcr", "<cmd>CBcrbox<cr>", desc = "Center Box Right Text", mode = { "n", "v" } },
      { "<leader>abrl", "<cmd>CBrlbox<cr>", desc = "Right Box Left Text", mode = { "n", "v" } },
      { "<leader>abrc", "<cmd>CBrcbox<cr>", desc = "Right Box Center Text", mode = { "n", "v" } },
      { "<leader>abrr", "<cmd>CBrrbox<cr>", desc = "Right Box Right Text", mode = { "n", "v" } },
      { "<leader>abal", "<cmd>CBlabox<cr>", desc = "Left Adapted Box", mode = { "n", "v" } },
      { "<leader>abac", "<cmd>CBcabox<cr>", desc = "Center Adapted Box", mode = { "n", "v" } },
      { "<leader>abar", "<cmd>CBrabox<cr>", desc = "Right Adapted Box", mode = { "n", "v" } },

      -- Titled Lines
      { "<leader>atll", "<cmd>CBllline<cr>", desc = "Left Line Left Text", mode = { "n", "v" } },
      { "<leader>atlc", "<cmd>CBlcline<cr>", desc = "Left Line Center Text", mode = { "n", "v" } },
      { "<leader>atlr", "<cmd>CBlrline<cr>", desc = "Left Line Center Text", mode = { "n", "v" } },
      { "<leader>atcl", "<cmd>CBclline<cr>", desc = "Center Line Left Text", mode = { "n", "v" } },
      { "<leader>atcc", "<cmd>CBccline<cr>", desc = "Center Line Center Text", mode = { "n", "v" } },
      { "<leader>atcr", "<cmd>CBcrline<cr>", desc = "Center Line Right Text", mode = { "n", "v" } },
      { "<leader>atrl", "<cmd>CBrlline<cr>", desc = "Right Line Left Text", mode = { "n", "v" } },
      { "<leader>atrc", "<cmd>CBrcline<cr>", desc = "Right Line Center Text", mode = { "n", "v" } },
      { "<leader>atrr", "<cmd>CBrrline<cr>", desc = "Right Line Right Text", mode = { "n", "v" } },

      -- Lines 
      { "<leader>all", "<cmd>CBline<cr>", desc = "Left Line", mode = { "n", "v" } },
      { "<leader>alc", "<cmd>CBcline<cr>", desc = "Center Line", mode = { "n", "v" } },
      { "<leader>alr", "<cmd>CBrline<cr>", desc = "Right Line", mode = { "n", "v" } },

      { "<leader>ad", "<cmd>CBd<cr>", desc = "[comment-box] remove box/titled line", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>CBcatalog<cr>", desc = "[comment-box] styles catalog" },
      { "<leader>aa", "<cmd>CBllbox14<cr>", desc = "[comment-box] marked", mode = { "n", "v" } }, 
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "annotation/snippets", icon = " ", mode = { "n", "v" } },
        { "<leader>ab", group = "[comment-box] boxes", mode = { "n", "v" }, icon = "󱃣 " },
        { "<leader>at", group = "[comment-box] titled lines", mode = { "n", "v" }, icon = "󱀡 " },
        { "<leader>al", group = "[comment-box] lines", mode = { "n", "v" }, icon = " " },
        { "<leader>ac", group = "[comment-box] styles catalog", icon = " " },
        { "<leader>abl", group = "Left Aligned" },
        { "<leader>abc", group = "Center Aligned" },
        { "<leader>abr", group = "Right Aligned" },
        { "<leader>aba", group = "Adapted" },
        { "<leader>atl", group = "Left Aligned" },
        { "<leader>atc", group = "Center Aligned" },
        { "<leader>atr", group = "Right Aligned" },
      },
    },
  },
}
