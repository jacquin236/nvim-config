---@diagnostic disable: undefined-global
return {
  s(
    {
      trig = "eof",
      name = "Create Heredoc",
      dscr = "Create a heredoc",
    },
    fmt(
      [[
        EOF << lua
        {}
        EOF
      ]],
      { i(1) }
    )
  ),
}
