local actions = require("telescope.actions")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>ssa",
        LazyVim.pick("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
            "Enum",
            "Constant",
          },
        }),
        desc = "All",
      },
      { "<leader>ssc", LazyVim.pick("lsp_document_symbols", { symbols = { "Class" } }), desc = "Class" },
      { "<leader>ssf", LazyVim.pick("lsp_document_symbols", { symbols = { "Function" } }), desc = "Function" },
      { "<leader>ssm", LazyVim.pick("lsp_document_symbols", { symbols = { "Method" } }), desc = "Method" },
      { "<leader>ssC", LazyVim.pick("lsp_document_symbols", { symbols = { "Constructor" } }), desc = "Constructor" },
      { "<leader>sse", LazyVim.pick("lsp_document_symbols", { symbols = { "Enum" } }), desc = "Enum" },
      { "<leader>ssi", LazyVim.pick("lsp_document_symbols", { symbols = { "Interface" } }), desc = "Interface" },
      { "<leader>ssM", LazyVim.pick("lsp_document_symbols", { symbols = { "Module" } }), desc = "Module" },
      { "<leader>sss", LazyVim.pick("lsp_document_symbols", { symbols = { "Struct" } }), desc = "Struct" },
      { "<leader>sst", LazyVim.pick("lsp_document_symbols", { symbols = { "Trait" } }), desc = "Trait" },
      { "<leader>ssF", LazyVim.pick("lsp_document_symbols", { symbols = { "Field" } }), desc = "Field" },
      { "<leader>ssp", LazyVim.pick("lsp_document_symbols", { symbols = { "Property" } }), desc = "Property" },
      {
        "<leader>ssv",
        LazyVim.pick("lsp_document_symbols", { symbols = { "Variable", "Parameter" } }),
        desc = "Variable/Parameters",
      },

      {
        "<leader>sSa",
        LazyVim.pick("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
            "Enum",
            "Constant",
          },
        }),
        desc = "All",
      },
      { "<leader>sSc", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Class" } }), desc = "Class" },
      { "<leader>sSf", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Function" } }), desc = "Function" },
      { "<leader>sSm", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Method" } }), desc = "Method" },
      {
        "<leader>sSC",
        LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Constructor" } }),
        desc = "Constructor",
      },
      { "<leader>sSe", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Enum" } }), desc = "Enum" },
      {
        "<leader>sSi",
        LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Interface" } }),
        desc = "Interface",
      },
      { "<leader>sSM", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Module" } }), desc = "Module" },
      { "<leader>sSs", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Struct" } }), desc = "Struct" },
      { "<leader>sSt", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Trait" } }), desc = "Trait" },
      { "<leader>sSF", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Field" } }), desc = "Field" },
      { "<leader>sSp", LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Property" } }), desc = "Property" },
      {
        "<leader>sSv",
        LazyVim.pick("lsp_dynamic_workspace_symbols", { symbols = { "Variable", "Parameter" } }),
        desc = "Variable/Parameters",
      },

      { "<leader>sA", LazyVim.pick("treesitter"), desc = "Treesitter Symbols" },
      { "<leader>sP", "<cmd>Telescope builtin<cr>", desc = "Pickers (Telescope)" },
      { "<leader>fh", LazyVim.pick("find_files", { hidden = true }), desc = "Find Files (hidden)" },
      { "<leader><c-space>", LazyVim.pick("find_files", { hidden = true }), desc = "Find Files (hidden)" },
      { "<leader>gf", "<cmd>Telescope git_bcommits<cr>", desc = "File History" },
      { "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "Git Stash" },
      { "<leader>gr", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
      { "<leader>S", "<cmd>Telescope spell_suggest<cr>", desc = "Spelling" },

      {
        "<leader>fP",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fl",
        function()
          local files = {}
          for _, plugin in pairs(require("lazy.core.config").plugins) do
            repeat
              if plugin._.module then
                local info = vim.loader.find(plugin._.module)[1]
                if info then
                  files[info.modpath] = info.modpath
                end
              end
              plugin = plugin._.super
            until not plugin
          end
          require("telescope.builtin").live_grep({ default_text = "/", search_dirs = vim.tbl_values(files) })
        end,
        desc = "Find Lazy Plugin Spec",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
          horizontal = { preview_width = { 0.7, max = 100, min = 30 } },
          vertical = { preview_cutoff = 20, preview_height = 0.85 },
          cursor = { height = 0.5, width = 0.8 },
        },
        sorting_strategy = "ascending",
        path_display = { filename_first = { reverse_directories = false } },
        dynamic_preview_title = true,
        winblend = 0,
      },
      mappings = {
        i = {
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<esc>"] = actions.close,
          ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
          ["<C-l>"] = require("telescope.actions.layout").cycle_layout_next,
          ["<C-h>"] = require("telescope.actions.layout").cycle_layout_prev,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<C-Tab>"] = require("telescope.actions").select_tab_drop,
          ["<M-h>"] = require("telescope.actions").results_scrolling_left,
          ["<M-l>"] = require("telescope.actions").results_scrolling_right,
        },
      },
      file_ignore_patterns = {
        ".gitignore",
        "node_modules",
        "build",
        "dist",
        "yarn.lock",
        "*.git/*",
        "*/tmp/*",
      },
    },
    pickers = {
      find_files = { hidden = true },
      buffers = {
        layout_config = {
          prompt_position = "top",
          height = 0.5,
          width = 0.6,
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-d>"] = require("telescope.actions").delete_buffer,
          },
        },
      },
      spell_suggest = {
        layout_config = {
          prompt_position = "top",
          height = 0.3,
          width = 0.25,
        },
        sorting_strategy = "ascending",
      },
      current_buffer_fuzzy_find = { layout_strategy = "vertical" },
      grep_string = { layout_strategy = "vertical" },
      lsp_references = { layout_strategy = "vertical" },
      lsp_definitions = { layout_strategy = "vertical" },
      lsp_type_definitions = { layout_strategy = "cursor" },
      lsp_implementations = { layout_strategy = "cursor" },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>sS"] = { name = "Goto Symbols (Workspace)" },
        ["<leader>ss"] = { name = "Goto Symbols" },
      },
    },
  },
}
