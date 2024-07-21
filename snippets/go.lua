---@diagnostic disable: undefined-global
return {
  snippet(
    { trig = "pr", name = "Print Var", dscr = "Print a variable" },
    fmt("fmt.Println({})", {
      i(1, "value"),
    })
  ),
}
