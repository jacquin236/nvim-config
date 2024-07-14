return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Git
      { "<leader>gf", "<cmd>Telescope git_bcommits<cr>", desc = "[git] file history" },
      { "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "[git] stash" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "[git] branches" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "[git] files" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "[git] commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "[git] status" },

      -- Files
      { "<leader>fr", false },
      { "<leader>fR", false },
      { "<leader>fc", false },
      { "<leader>fF", false },
      { "<leader>ff", "", desc = "Find Files" },
      { "<leader>fg", false },
      { "<leader>ffg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>ffc", LazyVim.pick.config_files(), desc = "Config File" },
      { "<leader>fff", LazyVim.pick("auto"), desc = "Files (Root Dir)" },
      { "<leader>ffF", LazyVim.pick("auto", { root = false }), desc = "Files (cwd)" },
      { "<leader>ffr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>ffR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent Files (cwd)" },
      {
        "<leader>ffP",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Plugin File (Root)",
      },
      {
        "<leader>lpf",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Lazy Plugin File",
      },
      {
        "<leader>lps",
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
        desc = "Lazy Plugin Spec",
      },
      {
        "<leader>ffp",
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
        desc = "Plugin Spec",
      },
      -- Search
      { "<leader>sa", false },
      { "<leader>sc", "", desc = "Command" },
      { "<leader>sC", false },
      { "<leader>sca", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sch", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>scc", "<cmd>Telescope commands<cr>", desc = "Commands" },

      { "<leader>sd>", "", desc = "Document/Workspace Diagnostics" },
      { "<leader>sD", false },
      { "<leader>sdd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sdw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },

      -- Goto Symbols (lsp)
      { "<leader>ss", false },
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
        desc = "Variable",
      },
      { "<leader>sS", false },
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
        desc = "Variable",
      },
      { "<leader>sA", LazyVim.pick("treesitter"), desc = "Treesitter Symbols" },
      { "<leader>sP", "<cmd>Telescope builtin<cr>", desc = "Pickers (Telescope)" },
      { "<leader>ffh", LazyVim.pick("find_files", { hidden = true }), desc = "Hidden Files" },
      { "<leader><c-space>", LazyVim.pick("find_files", { hidden = true }), desc = "Hidden Files" },

      { "<leader>S", "<cmd>Telescope spell_suggest<cr>", desc = "Spelling" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>sS", group = "goto symbols (workspace)", icon = " " },
        { "<leader>ss", group = "goto symbols (dynamic)", icon = " " },
        { "<leader>lp", group = "plugins", icon = " " },
        { "<leader>s#", group = "Headings", icon = " " },
        { "<leader>sI", group = "Imports", icon = " " },
        { "<leader>sp", group = "Snippets", icon = " " },
        { "<leader>su", group = "Undos", icon = " " },
        { "<leader>sc", group = "command", icon = "󰘳 " },
        { "<leader>sd", group = "document diagnostics", icon = " " },
      },
    },
  },
}
