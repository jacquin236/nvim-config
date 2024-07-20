local cell_marker = [[# %%]]

return {
  {
    -- Define code cell object `ir`, `ar`
    "echasnovski/mini.ai",
    opts = function(_, opts)
      opts.custom_textobjects["r"] = function(ai_mode, _, _) --Repl Code Cell Object
        local buf_nlines = vim.api.nvim_buf_line_count(0)
        local cell_markers = {}

        for line_no = 1, buf_nlines do
          if vim.fn.getline(line_no):sub(1, 4) == cell_marker then
            table.insert(cell_markers, line_no)
          end
        end

        table.insert(cell_markers, 1, 0) -- Beginning
        table.insert(cell_markers, #cell_markers + 1, buf_nlines + 1)

        local regions = {}
        for i = 1, #cell_markers - 1 do
          local from_line = ai_mode == "i" and cell_markers[i] + 1 or math.max(cell_markers[i], 1)
          -- for `around cell` on empty line select previous cell
          local to_line = cell_markers[i + 1] - 1
          local to_line_len = vim.fn.getline(to_line):len() + 1
          table.insert(regions, {
            from = { line = from_line, col = 1 },
            to = { line = to_line, col = to_line_len },
          })
        end
        return regions
      end
    end,
  },
}
