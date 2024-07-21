return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {
      headerMaxWidth = 80,
      windowCreationCommand = "tabnew %",
      keymaps = {
        replace = { n = "<localleader>sr" },
        qflist = { n = "<localleader>sq" },
        syncLocations = { n = "<localleader>sL" },
        syncLine = { n = "<localleader>sl" },
        close = { n = "<localleader>sc" },
        historyOpen = { n = "<localleader>sh" },
        historyAdd = { n = "<localleader>sH" },
        refresh = { n = "<localeader>sR" },
        openLocation = { n = "<localleader>so" },
        abort = { n = "<localleader>sb" },
        toggleShowRgCommand = { n = "<localleader>sC" },
      },
      spinnerStates = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
      icons = {
        enabled = true,
        replaceInput = "󰬳 ",
        resultsStatusError = " ",
        resultsStatusSuccess = " ",
        resultsActionMessage = " ",
        historyTitle = "   ",
        helpTitle = " 󰋖 ",
      },
    },
    config = function(_, opts)
      require("grug-far").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<localleader>s", group = "Search&Replace (GrugFar)", icon = "󰛔 " },
      },
    },
  },
}
