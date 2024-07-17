local function goto_headline(which)
  local ts_utils = require("nvim-treesitter.ts_utils")
  local tsparser = vim.treesitter.get_parser()
  local tstree = tsparser:parse()
  local root = tstree[1]:root()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_range = { cursor[1] - 1, cursor[2] }

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
  ---@diagnostic disable-next-line: unknown-cast-variable
  for _, captures, metadata in query:iter_matches(root) do
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
  hook = function(keybinds)
    local prefix = vim.g.maplocalleader
    local neorg_prefix = prefix .. "n"

    keybinds.map("norg", "n", neorg_prefix .. "e", function()
      vim.cmd([[!norgc '%' gfm >/dev/null]])
    end, { desc = "[neorg] Export to Markdown and Open File" })

    keybinds.map("norg", "n", neorg_prefix .. "q", "<cmd>Neorg return<cr>", { desc = "[neorg] Return" })

    keybinds.map("norg", "n", "[h", function()
      goto_headline("previous")
    end, { desc = "[nerog] Goto Previous Headline" })

    keybinds.map("norg", "n", "]h", function()
      goto_headline("next")
    end, { desc = "[neorg] Goto Next Headline" })

    keybinds.map("norg", "n", neorg_prefix .. "x", "<cmd>Neorg exec cursor<cr>", { desc = "[neorg] Exec Cursor" })
    keybinds.map(
      "norg",
      "n",
      neorg_prefix .. "X",
      "<cmd>Neorg exec current_file<cr>",
      { desc = "[nerog] Exec Current File" }
    )

    keybinds.map_event(
      "norg",
      "n",
      neorg_prefix .. "c",
      "core.looking-glass.magnify-code-block",
      { desc = "[neorg] Magnify Code Block" }
    )
    keybinds.map_event(
      "norg",
      "n",
      neorg_prefix .. "f",
      "core.integrations.telescope.find_linkable",
      { desc = "[neorg] Find Linkable (telescope)" }
    )
    keybinds.map_event(
      "norg",
      "n",
      neorg_prefix .. "F",
      "core.integrations.telescope.find_norg_files",
      { desc = "[neorg] Find Norg Files (telescope)" }
    )
    keybinds.map_event(
      "norg",
      { "n", "i" },
      neorg_prefix .. "i",
      "core.integrations.telescope.insert_file_link",
      { desc = "[neorg] Insert File Link (telescope)" }
    )
    keybinds.map_event(
      "norg",
      { "n", "i" },
      neorg_prefix .. "l",
      "core.integrations.telescope.insert_link",
      { desc = "[neorg] Insert Link (telescope)" }
    )
    keybinds.map_event(
      "norg",
      "n",
      neorg_prefix .. "s",
      "core.integrations.telescope.search_headings",
      { desc = "[neorg] Search Headings (telescope)" }
    )
    keybinds.map_event(
      "norg",
      "n",
      neorg_prefix .. "S",
      "core.integrations.telescope.switch_workspace",
      { desc = "[neorg] Switch Workspace (telescope)" }
    )
  end,
}
