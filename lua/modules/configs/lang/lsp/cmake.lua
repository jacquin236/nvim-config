return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cmake" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "cmakelang", "cmakelint" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = { cmake = { "cmakelint" } },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        neocmake = {
          filetypes = { "cmake" },
          root_dir = function(fname)
            return require("lspconfig").util.root_pattern("CMakePresets.json", "CTestConfig.cmake", "cmake")(fname)
          end,
        },
      },
    },
  },
  {
    "Civitasv/cmake-tools.nvim",
    init = function()
      local loaded = false
      local function check()
        if vim.fn.filereadable(vim.uv.cwd .. "/CMakeLists.txt") == 1 then
          require("lazy").load({ plugins = { "cmake-tools.nvim" } })
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,
    opts = {},
  },
}
