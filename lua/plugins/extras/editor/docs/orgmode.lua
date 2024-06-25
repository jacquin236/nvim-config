local border = require("util.ui").border

return {
  "nvim-orgmode/orgmode",
  opts = {
    ui = {
      menu = {
        handler = function(data)
          local items = vim
            .iter(data.items)
            :map(function(i)
              return (i.key and not i.label:lower():match("quit")) and i or nil
            end)
            :totable()

          vim.ui.select(items, {
            prompt = string.format(" %s ", data.prompt),
            kind = "orgmode",
            format_item = function(item)
              return string.format("%s → %s", item.key, item.label)
            end,
          }, function(choice)
            if not choice then
              return
            end
            if choice.action then
              choice.action()
            end
          end)
        end,
      },
    },
    org_agenda_files = { "~/projects/org/**/*" },
    org_default_notes_file = { "~/projects/org/refile.org" },
    org_todo_keywords = { "TODO", "WAITING", "IN-PROGRESS", "|", "DONE", "CANCELLED" },
    org_todo_keyword_faces = {
      ["TODO"] = ":foreground #000000 :background #7cf89c :weight bold",
      ["WAITING"] = ":foreground #000000 :background #f0f070 :weight bold",
      ["IN-PROGRESS"] = ":foreground #000000 :background #80dbff :weight bold",
      ["DONE"] = ":foreground #2bedc0 :weight bold",
      ["CANCELLED"] = ":foreground #000000 :background #e86f54 :weight bold",
    },
    org_hide_emphasis_markers = true,
    org_hide_leading_stars = true,
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,
    org_agenda_templates = {
      t = { description = "Task", template = "* TODO %?\n %u" },
      l = { description = "Link", template = "* %?\n%a" },
      n = { description = "Note", template = "* %?\n", target = "~/projects/org/**/notes.org" },
      p = {
        description = "Project TODO",
        template = "* TODO %? \nSCHEDULED: %t",
        target = "~/projects/org/**/projects.org",
      },
    },
    win_border = border,
    notifications = {
      enabled = true,
      repeater_reminder_time = false,
      deadline_warning_reminder_time = true,
      reminder_time = 10,
      deadline_reminder = true,
      scheduled_reminder = true,
    },
  },
  config = function(_, opts)
    require("orgmode").setup(opts)
  end,
}
