local settings = require("config.settings")

local event = sbar.add("item", "widgets.next_event", {
  position = "right",
  update_freq = 60,
  icon = {
    string = "󰃰",
    color = settings.colors.magenta,
    padding_right = 4,
  },
  label = {
    string = "",
    font = settings.fonts.label(),
    max_chars = 50,
  },
})

local function update_display(result)
  result = result:gsub("[\n\r]", ""):gsub("^%s+", ""):gsub("%s+$", "")
  if result == "" then
    event:set({
      label = { string = "No events" },
      icon = { color = settings.colors.grey },
    })
  else
    event:set({
      label = { string = result, color = settings.colors.white },
      icon = { color = settings.colors.magenta },
    })
  end
end

event:subscribe({ "routine", "forced" }, function()
  sbar.exec(
    "/opt/homebrew/bin/icalBuddy -n -li 1 -nc -nrd -eed -ea -df '' -tf '%H:%M' -iep 'datetime,title' -po 'datetime,title' -b '' -ps '/ /' eventsToday 2>/dev/null",
    function(result)
      update_display(result or "")
    end
  )
end)

event:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'Calendar'")
end)
