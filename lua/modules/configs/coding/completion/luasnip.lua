return {
  { "garymjr/nvim-snippets", enabled = false },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")

      ls.config.set_config({
        region_check_events = "CursorMoved,CursorHold,InsertEnter",
        delete_check_events = "TextChanged,InsertLeave",
        history = true,
        enable_autosnippets = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              hl_mode = "combine",
              virtext = { { "●", "Operator" } },
            },
          },
          [types.insertNode] = {
            active = {
              hl_mode = "combine",
              virt_text = { { "●", "Type" } },
            },
          },
        },
        snip_env = {
          fmt = require("luasnip.extras.fmt").fmt,
          m = require("luasnip.extras").match,
          l = require("luasnip.extras").lambda,
          t = ls.text_node,
          f = ls.function_node,
          c = ls.choice_node,
          d = ls.dynamic_node,
          i = ls.insert_node,
          s = ls.snippet,
        },
      })

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load()
      ls.filetype_extend("c", { "cdoc" })
      ls.filetype_extend("cpp", { "cppdoc" })
      ls.filetype_extend("cs", { "csharpdoc" })
      ls.filetype_extend("java", { "javadoc" })
      ls.filetype_extend("typescript", { "tsdoc" })
      ls.filetype_extend("typescript", { "next-ts" })
      ls.filetype_extend("typescript", { "react-ts" })
      ls.filetype_extend("typescriptreact", { "javascript", "typescript" })
      ls.filetype_extend("javascript", { "jsdoc" })
      ls.filetype_extend("javascript", { "next" })
      ls.filetype_extend("javascript", { "react" })
      ls.filetype_extend("lua", { "luadoc" })
      ls.filetype_extend("php", { "phpdoc" })
      ls.filetype_extend("python", { "pydoc", "comprehension" })
      ls.filetype_extend("ruby", { "rdoc" })
      ls.filetype_extend("rust", { "rustdoc" })
      ls.filetype_extend("sh", { "shelldoc" })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets/vscode" })

      vim.snippet.expand = ls.lsp_expand

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.snippet.active = function(filter)
        filter = filter or {}
        filter.direction = filter.direction or 1

        if filter.direction == 1 then
          return ls.expand_or_jumpable()
        else
          return ls.jumpable(filter.direction)
        end
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.snippet.jump = function(direction)
        if direction == 1 then
          if ls.expandable() then
            return ls.expand_or_jump()
          else
            return ls.jumpable(1) and ls.jump(1)
          end
        else
          return ls.jumpable(-1) and ls.jump(-1)
        end
      end

      vim.snippet.stop = ls.unlink_current

      for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
        loadfile(ft_path)()
      end

      local map = vim.keymap.set
      map({ "i", "s" }, "<c-k>", function()
        return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
      end, { silent = true })

      map({ "i", "s" }, "<c-j>", function()
        return vim.snippet.activve({ direction = -1 }) and vim.snippet.jump(-1)
      end, { silent = true })
    end,
  },
}
