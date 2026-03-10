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
    font = {
      family = settings.fonts.text,
      style = settings.fonts.styles.regular,
      size = 12.0,
    },
    max_chars = 50,
    scroll_texts = false,
  },
})

event:subscribe({ "routine", "forced" }, function()
  sbar.exec(
    "cat /tmp/sketchybar_next_event 2>/dev/null",
    function(result)
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
  )
end)

event:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'Calendar'")
end)
