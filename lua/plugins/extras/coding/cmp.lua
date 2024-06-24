return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    keys = {
      { "<leader>ciC", "<cmd>CmpStatus<CR>", desc = "Cmp Status" },
    },
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      "lukas-reineke/cmp-rg",
      "rafamadriz/friendly-snippets",
      "SergioRibera/cmp-dotenv",
      {
        "garymjr/nvim-snippets",
        opts = { friendly_snippets = true }
      },
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
      {
        "David-Kunz/cmp-npm",
        dependencies = "nvim-lua/plenary.nvim",
        ft = "json",
        opts = {},
      },
      "amarakon/nvim-cmp-fonts",
      "chrisgrieser/cmp-nerdfont",
      "lukas-reineke/cmp-under-comparator",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local border = require("util.ui").border
      local luasnip = require("luasnip")

      opts.completion = {
        keyword_length = 2
      }

      opts.performance = {
        debounce = 20,
        throttle = 20,
        fetching_timeout = 20,
        confirm_resolve_timeout = 20,
        async_budget = 1,
        max_view_entries = 50,
      }

      opts.snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      }

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      })

      opts.window = {
        completion = {
          border = border,
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
      }

      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local lspkind = require("lspkind")
          local kind = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
          })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
      }

      opts.sources = {
        { name = "nvim_lsp", group_index = 1 },
        { name = "luasnip",  group_index = 1 },
        { name = "path",     group_index = 1 },
        {
          name = "rg",
          keyword_length = 3,
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
        { name = "npm",     keyword_length = 4 },
        { name = "emoji" },
        { name = "dotenv" },
        {
          name = "fonts",
          option = { space_filter = "-" }
        },
        { name = "nerdfont" }
      }

      table.insert(opts.sorting.comparators, 4, require("cmp-under-comparator").under)
    end,
  },
}
