local colors = require("util.colors")

return {
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  lsp = {
    --- This is a mapping of LSP Kinds to highlight groups. LSP Kinds come via the LSP spec
    --- see: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
    highlights = {
      File = "Directory",
      Snippet = "Label",
      Text = "@string",
      Method = "@method",
      Function = "@function",
      Constructor = "@constructor",
      Field = "@field",
      Variable = "@variable",
      Module = "@namespace",
      Property = "@property",
      Unit = "@constant",
      Value = "@variable",
      Enum = "@type",
      Keyword = "@keyword",
      Reference = "@parameter.reference",
      Constant = "@constant",
      Struct = "@structure",
      Event = "@variable",
      Operator = "@operator",
      Namespace = "@namespace",
      Package = "@include",
      String = "@string",
      Number = "@number",
      Boolean = "@boolean",
      Array = "@repeat",
      Object = "@type",
      Key = "@field",
      Null = "@symbol",
      EnumMember = "@field",
      Class = "@lsp.type.class",
      Interface = "@lsp.type.interface",
      TypeParameter = "@lsp.type.parameter",
    },
    colors = {
      error = colors.red,
      warn = colors.yellow,
      hint = colors.oceanblue,
      info = colors.green,
    },
  },
}
