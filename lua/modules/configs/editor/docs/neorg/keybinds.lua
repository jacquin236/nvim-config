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
  hook = function(keybinds)
    local prefix = "<leader>on"

    -- Headline
    keybinds.map("norg", "n", "[h", function()
      goto_headline("previous")
    end, { desc = "[neorg] GoTo Previous Headline" })

    keybinds.map("norg", "n", "]h", function()
      goto_headline("next")
    end, { desc = "[neorg] GoTo Next Headline" })

    -- Telescope
    keybinds.map_event(
      "norg",
      "n",
      prefix .. "l",
      "core.integrations.telescope.find_linkable",
      { desc = "[telescope-neorg] Find Linkable" }
    )

    keybinds.map_event(
      "norg",
      "i",
      "<C-l>",
      "core.intergrations.telescope.insert_link",
      { desc = "[telescope-neorg] Insert Link" }
    )

    -- Others
    keybinds.map_event(
      "norg",
      "n",
      prefix .. "m",
      "core.looking-glass.magnify-code-block",
      { desc = "[neorg] Magnify Code Block" }
    )

    keybinds.map("norg", "n", prefix .. "q", "<cmd>Neorg return<cr>", { desc = "[neorg] Return" })
    keybinds.map("norg", "n", prefix .. "u", "<cmd>Neorg exec cursor<cr>", { desc = "[neorg] Exec cursor" })
    keybinds.map("norg", "n", prefix .. "c", "<cmd>Neorg exec current-file<cr>", { desc = "[neorg] Exec current file" })
  end,
}
