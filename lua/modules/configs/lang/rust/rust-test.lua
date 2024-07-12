return {
  "nvim-neotest/neotest",
  dependencies = { "mrcjkb/rustaceanvim" },
  opts = {
    adapters = {
      ["rustaceanvim.neotest"] = {},
    },
  },
}
