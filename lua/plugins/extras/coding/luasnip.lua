return {
  { import = "lazyvim.plugins.extras.coding.luasnip" },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")
      local extras = require("luasnip.extras")
      local fmt = require("luasnip.extras.fmt").fmt

      ls.config.set_config({
        history = false,
        region_check_events = "CursorMoved,CursorHold,InsertEnter",
        delete_check_events = "InsertLeave",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "Operator" } },
              hl_mode = "combine",
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "●", "Type" } },
              hl_mode = "combine",
            },
          },
        },
        ext_base_prio = 300,
        enable_autosnippets = true,
        snip_env = {
          fmt = fmt,
          m = extras.match,
          t = ls.text_node,
          f = ls.function_node,
          c = ls.choice_node,
          d = ls.dynamic_node,
          i = ls.insert_node,
          l = extras.lambda,
          snippet = ls.snippet,
        },
      })

      require("luasnip.loaders.from_lua").lazy_load()

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })

      ls.filetype_extend("typescript", { "tsdoc", "next-ts", "react-ts" })
      ls.filetype_extend("javascript", { "jsdoc", "next", "react" })
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
      ls.filetype_extend("NeogitCommitMessage", { "gitcommit" })
    end,
  },
}
