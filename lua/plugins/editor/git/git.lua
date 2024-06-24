local prefix = "<leader>G"

return {
  { import = "lazyvim.plugins.extras.util.octo" },
  { import = "plugins.lang.git" },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gh" })
    end
  },
  {
    "almo7aya/openingh.nvim",
    cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
    keys = {
      { prefix .. "ro", "<cmd>OpenInGHRepo<CR>",      desc = "Open git repo in web",     mode = { "n" } },
      { prefix .. "rf", "<cmd>OpenInGHFile<CR>",      desc = "Open git file in web",     mode = { "n" } },
      { prefix .. "rc", "<cmd>OpenInGHFileLines<CR>", desc = "Open current line in web", mode = { "n", "x", "v" } },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>G"] = { name = " Github" },
        ["<leader>Gc"] = { name = "Ccomments" },
        ["<leader>Gt"] = { name = "Threads" },
        ["<leader>Gi"] = { name = "Issues" },
        ["<leader>Gp"] = { name = "Pull Requests" },
        ["<leader>Gpm"] = { name = "Merge Current PR" },
        ["<leader>Gr"] = { name = "Repo" },
        ["<leader>Ga"] = { name = "Assignee/Reviewer" },
        ["<leader>Gl"] = { name = "Label" },
        ["<leader>Ge"] = { name = "Reaction" },
        ["<leader>GR"] = { name = "Review" },
        ["<leader>Gg"] = { name = "Gist" },
      },
    },
  },
}
