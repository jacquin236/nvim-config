return function()
  local icons = require("util.icons")

  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  local cmp = require("cmp")
  cmp.setup({
    preselect = cmp.PreselectMode.None,
    window = {
      completion = {
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
        scrollbar = false,
        col_offset = -3,
        side_padding = 1,
      },
      documentation = {
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
        scrollbar = false,
      },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        require("cmp-under-comparator").under,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },

    snippet = {
      expand = function(args)
        vim.snippet.lsp_expand(args.body)
      end,
    },

    formatting = {
      expandable_indicator = true,
      fields = { "abbr", "kind", "menu" },
      format = function(entry, vim_item)
        local lspkind_ok, lspkind = pcall(require, "lspkind")
        if not lspkind_ok then
          local lsp_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
          vim_item.kind = string.format("%s %s", lsp_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")
          vim_item.menu = setmetatable({
            buffer = "(Buffer)",
            codeium = "(Codeium)",
            copilot = "(Copilot)",
            orgmode = "(Org)",
            norg = "(Norg)",
            luasnip = "(Snippet)",
            git = "(Git)",
            path = "(Path)",
            emoji = "(Emoji)",
            nvim_lsp = "(Lsp)",
            nvim_lua = "(Lua)",
            spell = "(Spell)",
            treesitter = "(Treesitter)",
          }, {
            __index = function()
              return "(Builtin)"
            end,
          })[entry.source.name]

          local label = vim_item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, 80)
          if truncated_label ~= label then
            vim_item.abbr = truncated_label .. icons.ui.Ellipsis
          end

          return vim_item
        else
          local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = " (" .. (strings[2] or "") .. ")"
          return kind
        end
      end,
    },

    performance = {
      async_budget = 1,
      max_view_entries = 120,
      debounce = 20,
      throttle = 20,
      fetching_timeout = 20,
      confirm_resolve_timeout = 20,
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
    }),

    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "lazydev", group_index = 0 },
      { name = "luasnip" },
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
      { name = "path" },
      { name = "nvim_lua" },
      { name = "spell", group_index = 2 },
      { name = "treesitter" },
    }),
    experimental = {
      ghost_text = { hl_group = "CmpGhostText" },
    },
  })

  cmp.setup.cmdline({ "/", "?" }, {
    completion = { completeopt = "menu,menuone,noinsert" },
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
  })

  cmp.setup.cmdline(":", {
    completion = { completeopt = "menu,menuone,noselect,noinsert" },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "cmdline" },
      { name = "cmdline_history" },
    }),
  })
end
