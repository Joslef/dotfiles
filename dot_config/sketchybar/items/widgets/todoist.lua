local settings = require("config.settings")

local cache = "/tmp/sketchybar_todoist_count"

local todoist = sbar.add("item", "widgets.todoist", {
  position = "right",
  update_freq = 300,
  icon = {
    string = "󰄬",
    color = settings.colors.red,
    padding_right = 4,
  },
  label = {
    string = "?",
    font = settings.fonts.label(),
  },
})

todoist:subscribe({ "routine", "forced" }, function()
  local f = io.open(cache, "r")
  local val = 0
  if f then
    val = tonumber(f:read("*a")) or 0
    f:close()
  end
  local color = settings.colors.white
  if val > 10 then
    color = settings.colors.red
  elseif val > 5 then
    color = settings.colors.orange
  end
  todoist:set({
    label = { string = tostring(val), color = color },
  })
end)

todoist:subscribe("mouse.clicked", function()
  sbar.exec("open 'todoist://app'")
end)
