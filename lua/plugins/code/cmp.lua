local ui = require("util.ui")
local border = ui.border

return {
  { "onsails/lspkind.nvim" },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "InsertEnter",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
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
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      "lukas-reineke/cmp-rg",
      {
        "petertriho/cmp-git",
        opts = {
          filetypes = { "gitcommit", "NeogitCommitMessage" },
        },
      },
      {
        "f3fora/cmp-spell",
        ft = { "gitcommit", "NeogitCommitMessage", "markdown", "norg", "org" },
      },
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "rafamadriz/friendly-snippets",
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local defaults = require("cmp.config.default")()
      local auto_select = true

      local hl = vim.api.nvim_set_hl
      hl(0, "CmpGhostText", { link = "Comment", default = true })
      hl(0, "CmpItemKindVariable", { link = "Variable" })
      hl(0, "CmpItemAbbrMatchFuzzy", { italic = true })
      hl(0, "CmpItemAbbrDeprecated", { link = "Comment", strikethrough = true })
      hl(0, "CmpItemMenu", { link = "Comment", italic = true })

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert", keyword_length = 2 },
        window = {
          completion = cmp.config.window.bordered({
            scrollbar = false,
            border = border,
            winhighlight = "NormalFloat:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder",
            col_offset = -3,
          }),
          documentation = cmp.config.window.bordered({
            border = border,
            winhighlight = "FloatBorder:FloatBorder",
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sorting = defaults.sorting,
        experimental = { ghost_text = { hl_group = "CmpGhostText" } },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
          ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = {
          { name = "nvim_lsp", group_index = 1 },
          { name = "luasnip",  group_index = 1 },
          { name = "path",     group_index = 1 },
          {
            name = "rg",
            keyword_length = 4,
            option = { additional_arguments = "--max-depth 8" },
            group_index = 1,
          },
          {
            name = "buffer",
            options = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
            group_index = 2,
          },
          { name = "spell",   group_index = 2 },
          { name = "snippets" },
          { name = "emoji" },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local lspkind = require("lspkind")
            local kind = lspkind.cmp_format({
              mode = "symbol_text",
              maxwidth = math.min(50, math.floor(vim.o.columns * 0.5)),
              menu = {
                nvim_lsp = "[LSP]",
                nvim_lua = "[LUA]",
                emoji = "[EMOJI]",
                path = "[PATH]",
                neorg = "[NEORG]",
                luasnip = "[SNIP]",
                dictionary = "[DIC]",
                buffer = "[BUF]",
                spell = "[SPELL]",
                orgmode = "[ORG]",
                norg = "[NORG]",
                rg = "[RG]",
                git = "[GIT]",
              },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
          end,
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "cmdline_history" },
        }),
      })
    end,
  },
  {
    "abecodes/tabout.nvim",
    event = "InsertCharPre",
    opts = {},
    keys = {
      {
        "<Tab>",
        function()
          if vim.snippet.jumpable(1) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
            return
          end
          return vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, false)
        end,
        expr = true,
        mode = "i",
      },
      {
        "<Tab>",
        function()
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        end,
        silent = true,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          if vim.snippet.jumpable(-1) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
            return
          end
          return vim.api.nvim_replace_termcodes("<Plug>(TaboutBack)", true, true, false)
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
}
