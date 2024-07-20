return {
  { "garymjr/nvim-snippets", enabled = false },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      ls.config.set_config({
        history = true,
        enable_autosnippets = true,
      })

      ls.filetype_extend("c", { "cdoc" })
      ls.filetype_extend("cpp", { "cppdoc" })
      ls.filetype_extend("cs", { "csharpdoc" })
      ls.filetype_extend("java", { "javadoc" })
      ls.filetype_extend("typescript", { "tsdoc" })
      ls.filetype_extend("typescript", { "next-ts" })
      ls.filetype_extend("typescript", { "react-ts" })
      ls.filetype_extend("javascript", { "jsdoc" })
      ls.filetype_extend("javascript", { "next" })
      ls.filetype_extend("javascript", { "react" })
      ls.filetype_extend("lua", { "luadoc" })
      ls.filetype_extend("php", { "phpdoc" })
      ls.filetype_extend("python", { "pydoc", "comprehension" })
      ls.filetype_extend("ruby", { "rdoc" })
      ls.filetype_extend("rust", { "rustdoc" })
      ls.filetype_extend("sh", { "shelldoc" })

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
