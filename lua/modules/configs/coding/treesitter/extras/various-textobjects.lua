return {
  {
    "chrisgrieser/nvim-various-textobjs",
    opts = { useDefaultKeymaps = false },
    vscode = true,
    -- stylua: ignore
    keys = {
      -- Markdown, toml
      { "im", ft = { "markdown", "toml" }, mode = { "o", "x" }, function() require("various-textobjs").mdlink("inner") end, desc = "Markdown Link" },
      { "am", ft = { "markdown", "toml" }, mode = { "o", "x" }, function() require("various-textobjs").mdlink("outer") end, desc = "Markdown Link" },
      -- Markdown
      { "iC", ft = { "markdown" }, mode = { "o", "x" }, function() require("various-textobjs").mdFencedCodeBlock("inner") end, desc = "CodeBlock" },
      { "aC", ft = { "markdown" }, mode = { "o", "x" }, function() require("various-textobjs").mdFencedCodeBlock("outer") end, desc = "CodeBlock" },
      { "ie", ft = { "markdown" }, mode = { "o", "x" }, function() require("various-textobjs").mdEmphasis("inner") end, desc = "Emphasis" },
      { "ae", ft = { "markdown" }, mode = { "o", "x" }, function() require("various-textobjs").mdEmphasis("outer") end, desc = "Emphasis" },
      -- python
      { "iy", ft = { "python" }, mode = { "o", "x" }, function() require("various-textobjs").pyTripleQuotes("inner") end, desc = "Triple Quotes" },
      { "ay", ft = { "python" }, mode = { "o", "x" }, function() require("various-textobjs").pyTripleQuotes("outer") end, desc = "Triple Quotes" },
      -- CSS
      { "iC", ft = { "css", "scss", "less" }, mode = { "o", "x" }, function() require("various-textobjs").cssSelector("inner") end, desc = "CSS Selector" },
      { "aC", ft = { "css", "scss", "less" }, mode = { "o", "x" }, function() require("various-textobjs").cssSelector("outer") end, desc = "CSS Selector" },
      { "i#", ft = { "css", "scss", "less" }, mode = { "o", "x" }, function() require("various-textobjs").cssColor("inner") end, desc = "CSS Color" },
      { "a#", ft = { "css", "scss", "less" }, mode = { "o", "x" }, function() require("various-textobjs").cssColor("outer") end, desc = "CSS Color" },
      -- shell 
      { "iP", ft = { "sh" }, mode = { "o", "x" }, function() require("various-textobjs").shellPipe("inner") end, desc = "Pipe" },
      { "aP", ft = { "sh" }, mode = { "o", "x" }, function() require("various-textobjs").shellPipe("outer") end, desc = "Pipe" },
      -- Html, css, scss, less, xml
      { "iH", ft = { "html, xml, css, scss, less" }, mode = { "o", "x" }, function() require("various-textobjs").htmlAttribute("inner") end, desc = "HTML Attribute" },
      -- Value
      { "iv", mode = { "o", "x" }, function() require("various-textobjs").value("inner") end, desc = "Value" },
      { "av", mode = { "o", "x" }, function() require("various-textobjs").value("outer") end, desc = "Value" },
      -- Key
      { "ik", mode = { "o", "x" }, function() require("various-textobjs").key("inner") end, desc = "Key" },
      { "ak", mode = { "o", "x" }, function() require("various-textobjs").key("outer") end, desc = "Key" },
      -- Number
      { "iN", mode = { "o", "x" }, function() require("various-textobjs").number("inner") end, desc = "Number" },
      { "aN", mode = { "o", "x" }, function() require("various-textobjs").number("outer") end, desc = "Number" },
      -- Indent
      { "i.", mode = { "o", "x" }, function() require("various-textobjs").chainMember("inner") end, desc = "Indent" },
      { "a.", mode = { "o", "x" }, function() require("various-textobjs").chainMember("outer") end, desc = "Indent" },
      { "ig", mode = { "o", "x" }, function() require("various-textobjs").greedyOuterIndentation("inner") end, desc = "Greedy Indent" },
      { "ag", mode = { "o", "x" }, function() require("various-textobjs").greedyOuterIndentation("outer") end, desc = "Greedy Indent" },

      -- Others
      { "gd", mode = { "o", "x" }, function() require("various-textobjs").diagnostics() end, desc = "Diagnostics" },
      { "L", mode = { "o", "x" }, function() require("various-textobjs").url() end, desc = "Link" },
      { "o", mode = "o", function() require("various-textobjs").column() end, desc = "Column" },

      { "rp", mode = "o", function() require("various-textobjs").restOfParagraph() end, desc = "Rest of Paragraph" },
      { "ri", mode = "o", function() require("various-textobjs").restOfIndentation() end, desc = "Rest of Indentation"},

      { "a[", mode = "o", function() require("various-textobjs").anyBracket("outer") end, desc = "anyBracket" },
      { "i[", mode = "o", function() require("various-textobjs").anyBracket("inner") end, desc = "anyBracket" },

      { 'a"', mode = "o", function() require("various-textobjs").anyQuote("outer") end, desc = "anyQuote" },
      { 'i"', mode = "o", function() require("various-textobjs").anyQuote("inner") end, desc = "anyQuote" },

    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "a", group = "Outer (text objects)", mode = { "o", "x" } },
        { "i", group = "Inner (text objects)", mode = { "o", "x" } },
      },
    },
  },
}
