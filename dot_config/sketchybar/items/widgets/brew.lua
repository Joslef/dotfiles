local settings = require("config.settings")

local cache = "/tmp/sketchybar_brew_count"

local brew = sbar.add("item", "widgets.brew", {
  position = "right",
  update_freq = 3600,
  icon = {
    string = "󰏗",
    color = settings.colors.green,
    padding_right = 4,
  },
  label = {
    string = "?",
    font = settings.fonts.label(),
  },
})

brew:subscribe({ "routine", "forced" }, function()
  -- brew outdated crashes inside sketchybar's sandbox, so read from cache file
  -- updated by launchd: com.sketchybar.brew-outdated
  local f = io.open(cache, "r")
  local val = 0
  if f then
    val = tonumber(f:read("*a")) or 0
    f:close()
  end
  local color = settings.colors.white
  if val > 20 then
    color = settings.colors.red
  elseif val > 10 then
    color = settings.colors.orange
  end
  brew:set({
    label = { string = tostring(val), color = color },
  })
end)
