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
  local f = io.open("/tmp/sketchybar_next_event", "r")
  local result = f and f:read("*a") or ""
  if f then f:close() end
  update_display(result)
end)

event:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'Calendar'")
end)
