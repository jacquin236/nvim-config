local function import_suffix(import_name)
  local parts = vim.split(import_name[1][1], ".", true)
  return parts[#parts] or ""
end

---@diagnostic disable: undefined-global
return {
  s(
    {
      trig = "cfg",
      name = "Config key",
      dscr = "Package Manager Config Key",
    },
    fmt(
      [[
        , config = function()
          require("{}").setup()
        end
      ]],
      { i(1) }
    )
  ),
  s(
    {
      trig = "vs",
      name = "Vim Schedule",
      dscr = "Schedule a function on Vim Event Loop",
    },
    fmt(
      [[
        vim.schedule(function()
          {}
        end)
      ]],
      { i(1) }
    )
  ),
  s(
    {
      trig = "req",
      name = "Require module",
      dscr = "Require a Module and Set the Import to the Last Word",
    },
    fmt([[local {} = require("{}")]], {
      f(import_suffix, { 1 }),
      i(1),
    })
  ),
  s(
    {
      trig = "lreq",
      name = "Lazy Require Module",
      dscr = "Lazy Require a Module and Set the Import to the Last Word",
    },
    fmt(
      [[
      local {1} = lazy.require("{2}") ---@module "{3}"
      ]],
      {
        f(import_suffix, { 1 }),
        i(1),
        rep(1),
      }
    )
  ),
  s(
    {
      trig = "plg",
      name = "Plugin Spec",
      dscr = {
        "plugin spec block",
        "e.g.",
        "{'author/plugin'}",
      },
    },
    fmt([[{{"{}"{}}}]], {
      d(1, function()
        -- Get the author and URL in the clipboard and auto populate the author and project
        local default = snippet("", { i(1, "author"), t("/"), i(2, "plugin") })
        local clip = fn.getreg("*")
        if not vim.startswith(clip, "https://github.com/") then
          return default
        end
        local parts = vim.split(clip, "/")
        if #parts < 2 then
          return default
        end
        local author, project = parts[#parts - 1], parts[#parts]
        return snippet("", { t(author .. "/" .. project) })
      end),
      c(2, {
        fmt(
          [[
            , config = function()
              require("{}").setup()
            end
          ]],
          { i(1, "module") }
        ),
        t(""),
      }),
    })
  ),
  s(
    {
      trig = "if",
      condition = function()
        local ignored_nodes = { "string", "comment" }
        local pos = api.nvim_win_get_cursor(0)
        local row, col = pos[1] - 1, pos[2] - 1
        local node_type = vim.treesitter.get_node({ pos = { row, col } }):type()
        return not vim.tbl_contains(ignored_nodes, node_type)
      end,
    },
    fmt(
      [[
        if {} then
          {}
        end
      ]],
      { i(1), i(2) }
    )
  ),
}
