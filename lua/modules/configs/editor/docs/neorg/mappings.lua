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

-- stylua: ignore
return {
  { "<leader>oni", "<cmd>Neorg index<cr>", desc = "[neorg] Index" },
  { "<leader>onn", "<cmd>Neorg<cr>", desc = "[neorg] Options" },
  { "<leader>onq", "<cmd>Neorg return<cr>", desc = "[neorg] Return" },

  -- Headline
  { "[h", function() goto_headline("previous") end, desc = "[neorg] Goto Previous Headline" },
  { "]h", function() goto_headline("next") end, desc = "[neorg] Goto Next Headline" },

  { "<localleader>nx", "<cmd>Neorg exec cursor<cr>", desc = "[neorg] code block under cursor" },
  { "<localleader>nX", "<cmd>Neorg exec current-file<cr>", desc = "[neorg] code block whole file" },
  { "<localleader>nq", "<cmd>Neorg return<cr>", desc = "[neorg] return", remap = true },
  
  -- Telescope
  { "<localleader>ns", "<Plug>(neorg.telescope.search_headings)", desc = "[neorg] search headings (telescope)" },
  { "<localleader>nS", "<Plug>(neorg.telescope.switch_workspace)", desc = "[neorg] switch workspace (telescope)" },
  { "<localleader>nb", "<Plug>(neorg.telescope.backlinks.file_backlinks)", desc = "[neorg] file backlinks (telescope)" },
  { "<localleader>nB", "<Plug>(neorg.telescope.backlinks.header_backlinks)", desc = "[neorg] header backlinks (telescope)" },
  { "<localleader>nf", "<Plug>(neorg.telescope.find_linkable)", desc = "[neorg] find linkable (telecope)" },
  { "<localleader>nF", "<Plug>(neorg.telescope.find_norg_files)", desc = "[neorg] find norg files (telescope)" },
  { "<localleader>ni", "<Plug>(neorg.telescope.insert_link)", desc = "[neorg] insert link (telescope)" },
  { "<localleader>nI", "<Plug>(neorg.telescope.insert_file_link)", desc = "[neorg] insert file link (telescope)" },

  { "<localleader>nc", "<Plug>(neorg.looking-glass.magnigy-code-block)", desc = "[neorg] magnify code block" },
  { "<localleader>nn", "<Plug>(neorg.dirman.new-note)", desc = "[neorg] create new note" },

  -- Todo items
  { "<localleader>nmu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", desc = "undone" },
  { "<localleader>nmp", "<Plug>(neorg.qol.todo-items.todo.task-pending)", desc = "pending" },
  { "<localleader>nmd", "<Plug>(neorg.qol.todo-items.todo.task-done)", desc = "done" },
  { "<localleader>nmh", "<Plug>(neorg.qol.todo-items.todo.task-on-hold)", desc = "on-hold" },
  { "<localleader>nmc", "<Plug>(neorg.qol.todo-items.todo.task-cancalled)", desc = "cancelled" },
  { "<localleader>nmr", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", desc = "recurring" },
  { "<localleader>nmi", "<Plug>(neorg.qol.todo-items.todo.task-important)", desc = "important" },
  { "<localleader>nma", "<Plug>(nerog.qol.todo-items.todo.task-ambiguous)", desc = "ambiguous" },

  -- Toggle list from ordered <-> unordered
  { "<leader>onl", "<Plug>(neorg.pivot.list.toggle)", desc = "[neorg] Toogle (Un)ordered List" },
  { "<localleader>nl", "<Plug>(neorg.pivot.list.toggle)", desc = "[neorg] toggle (un)ordered list", remap = true },
  -- Insert all items in a list
  { "<localleader>nL", "<Plug>(neorg.pivot.list.invert)", desc = "[neorg] invert (un)ordered list" },
  -- Insert date 
  { "<localleader>nd", "<Plug>(neorg.tempus.insert-date)", desc = "[neorg] insert date" },
}
