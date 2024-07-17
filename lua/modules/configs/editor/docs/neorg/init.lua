local function goto_headline(which)
  local ts_utils = require("nvim-treesitter.ts_utils")
  local tsparser = vim.treesitter.get_parser()
  local tstree = tsparser:parse()
  local root = tstree[1]:root()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_range = { cursor[1] - 1, cursor[2] }
  -- Query all headings (from 1 to 6)
  local query = vim.treesitter.query.parse(
    "norg",
    [[
    (heading1) @h1
    (heading2) @h2
    (heading3) @h3
    (heading4) @h4
    (heading5) @h5
    (heading6) @h6
    ]]
  )
  local previous_headline = nil
  local next_headline = nil
  -- Find the previous and next heading from the captures
  for _, captures, metadata in query:iter_matches(root) do ---@diagnostic disable-line
    for _, node in pairs(captures) do
      local row = node:start()
      if row < cursor_range[1] then
        previous_headline = node
      elseif row > cursor_range[1] and next_headline == nil then
        next_headline = node
        break
      end
    end
  end
  if which == "previous" then
    ts_utils.goto_node(previous_headline)
  elseif which == "next" then
    ts_utils.goto_node(next_headline)
  end
end

return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    version = false,
    dependencies = {
      "luarocks.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-cmp",
      "mason.nvim",
      "plenary.nvim",
      "laher/neorg-exec",
      { "nvim-neorg/neorg-telescope", dependencies = "nvim-telescope/telescope.nvim" },
      { "pysan3/neorg-templates", dependencies = "L3MON4D3/LuaSnip" },
    },
    cmd = "Neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.concealer"] = {
            config = {
              icon_preset = "basic",
              icons = {
                code_block = { spell_check = false },
              },
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.defaults"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes/neorg",
                projects = "~/projects/notes/neorg",
              },
              default_workspace = "notes",
            },
          },
          ["core.esupports.hop"] = {},
          ["core.export"] = {},
          ["core.export.markdown"] = {},
          ["core.integrations.nvim-cmp"] = {},
          ["core.integrations.telescope"] = {
            config = {
              insert_file_link = {
                show_title_preview = true,
              },
            },
          },
          ["core.integrations.treesitter"] = {},
          ["core.journal"] = {
            config = {
              strategy = "nested",
            },
          },
          ["core.keybinds"] = {
            config = {
              default_keybinds = true,
            },
          },
          ["core.looking-glass"] = {},
          ["core.tangle"] = {
            config = {
              report_on_empty = false,
            },
          },
          ["external.exec"] = {},
          ["external.templates"] = {
            templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
            keywords = require("modules.configs.editor.docs.neorg.templates"),
          },
        },
      })
    end,
    init = function()
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "norg",
        command = "Neorg tangle current-file",
      })
    end,
    keys = {
      { "<leader>oni", "<cmd>Neorg index<cr>", desc = "[neorg] Index" },
      { "<leader>onn", "<cmd>Neorg<cr>", desc = "[neorg] Options" },
      { "<localleader>nx", "<cmd>Neorg exec cursor<cr>", desc = "[neorg] code block under cursor" },
      { "<localleader>nX", "<cmd>Neorg exec current-file<cr>", desc = "[neorg] code block whole file" },
      { "<localleader>nq", "<cmd>Neorg return<cr>", desc = "[neorg] return" },
      {
        "[h",
        function()
          goto_headline("previous")
        end,
        desc = "[neorg] Goto Previous Headline",
      },
      {
        "]h",
        function()
          goto_headline("next")
        end,
        desc = "[neorg] Goto Next Headlint",
      },
      { "<localleader>ns", "<Plug>(neorg.telescope.search_headings)", desc = "[neorg] search headings (telescope)" },
      { "<localleader>nS", "<Plug>(neorg.telescope.switch_workspace)", desc = "[neorg] switch workspace (telescope)" },
      {
        "<localleader>nb",
        "<Plug>(neorg.telescope.backlinks.file_backlinks)",
        desc = "[neorg] file backlinks (telescope)",
      },
      {
        "<localleader>nB",
        "<Plug>(neorg.telescope.backlinks.header_backlinks)",
        desc = "[neorg] header backlinks (telescope)",
      },
      {
        "<localleader>nf",
        "<Plug>(neorg.telescope.find_linkable)",
        desc = "[neorg] find linkable (telecope)",
      },
      { "<localleader>nF", "<Plug>(neorg.telescope.find_norg_files)", desc = "[neorg] find norg files (telescope)" },
      {
        "<localleader>ni",
        "<Plug>(neorg.telescope.insert_link)",
        desc = "[neorg] insert link (telescope)",
      },
      {
        "<localleader>nI",
        "<Plug>(neorg.telescope.insert_file_link)",
        desc = "[neorg] insert file link (telescope)",
      },
    },
  },
}
