return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
      { "petertriho/cmp-git", opts = { filetypes = { "gitcommit", "NeogitCommitMessage" } } },
    },
    opts = function(_, opts)
      opts.completion.keyword_length = 2
      opts.windows = {
        completion = require("cmp").config.window.bordered({
          scrollbar = false,
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "NormalFloat:Pmenu,Cursorline:PmenuSel,FloatBorder:FloatBorder",
        }),
        documentation = require("cmp").config.window.bordered({
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "FloatBorder:FloatBorder",
        }),
      }
      table.insert(opts.sources, { name = "snippets" })
      table.insert(opts.sources, { name = "luasnip" })
    end,

    config = function(_, opts)
      local cmp = require("cmp")
      for _, source in ipairs(opts.sources) do
        if source.name == "copilot" then
          source.group_index = 2
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
}
