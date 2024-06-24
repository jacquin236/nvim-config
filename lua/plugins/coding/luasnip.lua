return {
  { import = "lazyvim.plugins.extras.coding.luasnip" },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.til.types")
      local extras = require("luasnip.xtras")
      local fmt = require("luasnip.xtras.fmt").fmt

      ls.config.set_config({
        history = false,
        region_check_events = "CursorMoved,CursorHold,InsertEnter",
        delete_check_events = "InsertLeave",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              hl_mode = "combine",
              virt_text = { { "●", "Operator" } },
            },
          },
          [types.insertNode] = {
            active = {
              hl_mode = "combine",
              virt_text = { { "●", "Type" } },
            },
          },
        },
        enable_autosnippets = true,
        ---@diagnostic disable: no-unknown
        snip_env = {
          fmt = fmt,
          m = extras.match,
          t = ls.text_node,
          f = ls.function_node,
          c = ls.choice_node,
          d = ls.dynamic_node,
          i = ls.insert_node,
          l = extras.lamda,
          snippet = ls.snippet,
        },
      })

      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load()

      ls.filetype_extend("typescriptreact", { "javascript", "typescript" })
      ls.filetype_extend("NeogitCommitMessage", { "gitcommit" })
      ls.filetype_extend("typescript", { "tsdoc" })
      ls.filetype_extend("typescript", { "next-ts" })
      ls.filetype_extend("javascript", { "jsdoc" })
      ls.filetype_extend("javascript", { "next" })
      ls.filetype_extend("lua", { "luadoc" })
      ls.filetype_extend("python", { "pydoc" })
      ls.filetype_extend("rust", { "rustdoc" })
      ls.filetype_extend("cs", { "csharpdoc" })
      ls.filetype_extend("java", { "javadoc" })
      ls.filetype_extend("c", { "cdoc" })
      ls.filetype_extend("cpp", { "cppdoc" })
      ls.filetype_extend("php", { "phpdoc" })
      ls.filetype_extend("kotlin", { "kdoc" })
      ls.filetype_extend("ruby", { "rdoc" })
      ls.filetype_extend("sh", { "shelldoc" })

      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
    end,
  },
}
