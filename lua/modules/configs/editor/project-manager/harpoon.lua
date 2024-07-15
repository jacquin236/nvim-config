return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = { width = vim.api.nvim_win_get_width(0) - 4 },
      settings = { save_on_toggle = true },
    },
    keys = function()
      local keys = {
        { "<leader>Ph", function() require("harpoon"):list():add() end,                         desc = "[harpoon] add file" },
        { "<leader>Pm", function() require("harpoon").ui:toggle_quick_menu(harpoon:list()) end, desc = "[harpoon] quick menu" },
      }
      for i = 1, 8 do
        table.insert(keys, {
          "<leader>Pn" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "[harpoon] goto file " .. i,
        })
      end
      return keys
    end
  },
}
