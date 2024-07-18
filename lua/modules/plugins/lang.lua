return {
  { import = "modules.configs.lang.lua" },
  -- rust
  { import = "modules.configs.lang.rust" },
  -- json
  { import = "modules.configs.lang.json" },
  -- typescript
  { import = "modules.configs.lang.typescript" },
  -- yaml
  { import = "modules.configs.lang.yaml" },
  -- sql
  { import = "modules.configs.lang.sql" },
  -- markdown
  { import = "modules.configs.lang.markdown" },
  -- bash
  { import = "modules.configs.lang.bash" },
  -- go
  { import = "modules.configs.lang.go", enabled = false },
  -- python
  { import = "modules.configs.lang.python", enabled = false },
  -- docker
  { import = "modules.configs.lang.docker", enabled = false },
  -- ruby
  { import = "modules.configs.lang.ruby", enabled = false },
  -- log files
  { "fei6409/log-highlight.nvim", event = "BufRead *.log", opts = {} },
}
