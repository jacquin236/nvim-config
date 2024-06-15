return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "rafamadriz/friendly-snippets",
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
      "onsails/lspkind-nvim",
    },
    opts = function(_, opts)
      opts.completion.keyword_length = 1
      opts.window = {
        completion = {
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
          col_offset = -3,
          side_padding = 0,
        },
        documentation = {
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
        },
      }
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local lspkind = require("lspkind")
          local kind = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
          })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
      }

      table.insert(opts.sources, { name = "snippets" })
    end,

    config = function(_, opts)
      local cmp = require("cmp")
      local format_kinds = opts.formatting.format

      for _, source in ipairs(opts.sources) do
        if source.name == "copilot" then
          source.group_index = 2 --disable copilot on default
        else
          source.group_index = source.group_index or 1
        end
      end

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-l>"] = cmp.mapping.complete({
          config = {
            sources = vim.tbl_filter(function(source)
              return source.group_index == 2
            end, opts.sources),
          },
        }),
      })

      cmp.setup(opts)
      cmp.setup.cmdline({ "/", "?" }, {
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
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
    end,
  },
}
