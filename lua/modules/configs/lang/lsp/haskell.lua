return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "haskell" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "haskell-language-server" } },
  },
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3",
    lazy = false, -- This plugin is already lazy
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      optional = true,
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("ht")
      end

      vim.g.haskell_tools = {
        tools = {
          codeLens = { autoRefresh = false },
          hoogle = { mode = "auto" },
          repl = { handler = "toggleterm" },
          hover = {
            enable = true,
            stylize_markdown = true,
            auto_focus = true,
          },
          definition = { hoogle_signature_fallback = true },
          log = {
            level = vim.log.levels.INFO,
          },
        },
        hls = {
          on_attach = function(_, bufnr, ht)
            local map = vim.keymap.set
            local desc = function(description)
              return { noremap = true, silent = true, buffer = bufnr, desc = description }
            end

            map("n", "gh", ht.hoogle.hoogle_signature, desc("Hoogle Signature Search (haskell)"))
            map(
              "n",
              "<leader>hg",
              require("telescope").extensions.ht.package_grep,
              desc("[haskell] Package Grep (telescope)")
            )
            map(
              "n",
              "<leader>hG",
              require("telescope").extensions.ht.package_hsgrep,
              desc("[haskell] Package Grep Files (telescope)")
            )
            map("n", "<leader>hf", telescope.extensions.ht.package_files, desc("[haskell] Package Files (telescope)"))
            map("n", "<leader>he", ht.lsp.buf_eval_all, desc("[haskell] Evaluate All"))
            map("n", "<leader>hr", ht.repl.toggle, desc("[haskell] Toggle Repl"))
            map("n", "<leader>hR", ht.repl.reload, desc("[haskell] Reload Repl"))
            map("n", "<leader>hF", function()
              ht.repl.toggle(vim.api.nvim_buf_get_name(bufnr))
            end, desc("[haskell] Repl Toggle With File"))
            map("n", "<leader>hq", ht.repl.quit, desc("[haskell] Repl Quit"))
            map("n", "<leader>hp", ht.repl.paste, desc("[haskell] Repl Paste"))
            map("n", "<leader>ht", ht.repl.paste_type, desc("[haskell] Repl Paste Type from (register)"))
            map("n", "<leader>hT", ht.repl.cword_type, desc("[haskell] Repl Type of (cword)"))
            map(
              "n",
              "<leader>hh",
              '<cmd>TermExec cmd="cabal repl %"<cr>',
              desc("[haskell] Start Cabal Repl in Terminal")
            )
          end,
        },
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      if not vim.g.nvim_surround_setup then
        require("nvim-surround").setup()
        vim.g.nvim_surround_setup = true
      end

      ---@param items string[]
      ---@param prompt string?
      ---@param label_fn (fun(item:string):string) | nil
      ---@return string|nil
      local function ui_select_sync(items, prompt, label_fn)
        label_fn = label_fn or function(str)
          return str
        end
        local choices = { prompt }
        for i, item in ipairs(items) do
          table.insert(choices, string.format("%d: %s", i, label_fn(item)))
        end
        local choice = vim.fn.inputlist(choices)
        if choice < 1 or choice > #items then
          return nil
        end
        return items[choice]
      end

      require("nvim-surround").buffer_setup({
        surrounds = {
          ["L"] = {
            add = function()
              local level = ui_select_sync({ "e", "w", "i", "d", "t" }, "Select a log level")
              return level and { {
                "[Log." .. level .. "|",
              }, { "|]" } } or {}
            end,
          },
          ["Q"] = {
            add = { "[qq|", "|]" },
          },
        },
      })
    end,
  },
  {
    "mrcjkb/haskell-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip" },
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function()
      local haskell_snippets = require("haskell-snippets").all
      require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
    end,
  },
  {
    "luc-tielen/telescope_hoogle",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("hoogle")
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        hls = function()
          return true
        end,
      },
    },
  },
}
