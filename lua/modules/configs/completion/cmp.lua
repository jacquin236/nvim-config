local cmp_extended = function()
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

    formatting = {
      expandable_indicator = true,
      fields = { "abbr", "kind", "menu" },
      format = function(entry, vim_item)
        local lspkind_ok, lspkind = pcall(require, "lspkind")
        if not lspkind_ok then
          local lsp_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
          vim_item.kind = string.format("%s %s", lsp_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")
          vim_item.menu = setmetatable({
            copilot = "(Copilot)",
            buffer = "(Buffer)",
            orgmode = "(Org)",
            norg = "(Norg)",
            rg = "(Ripgrep)",
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
          kind.menu = "    (" .. (strings[2] or "") .. ")"
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
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_locally_jumpable() then
          require("luasnip").expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "nvim_lsp_signature_help", priority = 800 },
      { name = "luasnip", priority = 750 },
      { name = "lazydev", group_index = 0 },
      {
        name = "buffer",
        priority = 500,
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
      { name = "path", priority = 400 },
      { name = "nvim_lua" },
      {
        name = "rg",
        keyword_length = 4,
        option = { additional_arguments = "--max-depth 8" },
        group_index = 1,
      },
      { name = "spell", group_index = 2 },
      { name = "dotenv" },
      { name = "emoji" },
      { name = "fonts", option = { space_filter = "-" } },
      { name = "nerdfont" },
      { name = "treesitter", priority = 250 },
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

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "SergioRibera/cmp-dotenv",
    "hrsh7th/cmp-emoji",
    "amarakon/nvim-cmp-fonts",
    "chrisgrieser/cmp-nerdfont",
    "lukas-reineke/cmp-under-comparator",
    "David-Kunz/cmp-npm",
    "lukas-reineke/cmp-rg",
    "saadparwaiz1/cmp_luasnip",
    "ray-x/cmp-treesitter",
    { "f3fora/cmp-spell", ft = { "gitcommit", "NeogitCommitMessage", "markdown", "norg", "org" } },
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  keys = {
    { "<leader>iC", "<cmd>CmpStatus<CR>", desc = "cmp (status)" },
  },
  config = cmp_extended,
}
