return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = { "mrcjkb/rustaceanvim" },
  opts = {
    adapters = {
      ["rustaceanvim.neotest"] = {},
    },
  },
}
