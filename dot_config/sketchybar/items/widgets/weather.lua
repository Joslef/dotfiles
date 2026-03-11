local settings = require("config.settings")

-- Pattern-based weather icon matching (checked in order, first match wins)
local weatherPatterns = {
  { "thunder", "⛈️" },
  { "snow", "🌨️" },
  { "blizzard", "❄️" },
  { "ice", "🌨️" },
  { "sleet", "🌨️" },
  { "freezing", "🌨️" },
  { "heavy.*rain", "🌧️" },
  { "moderate.*rain", "🌧️" },
  { "rain", "🌦️" },
  { "shower", "🌦️" },
  { "drizzle", "🌦️" },
  { "mist", "🌫️" },
  { "fog", "🌫️" },
  { "haze", "🌫️" },
  { "overcast", "☁️" },
  { "cloudy", "⛅" },
  { "clear", "☀️" },
  { "sunny", "☀️" },
  { "fair", "☀️" },
  { "vicinity", "🌦️" },
}

sbar.add("item", "widgets.weather.gap", { position = "right", width = 5 })

local weather = sbar.add("item", "widgets.weather", {
  position = "right",
  update_freq = 900,
  icon = {
    string = "🌡️",
    padding_right = 2,
  },
  label = {
    string = "…",
    font = settings.fonts.label(),
  },
})

weather:subscribe({ "routine", "forced" }, function()
  sbar.exec("curl -s --max-time 10 'wttr.in/Munich,Bayern?format=%t|%C' 2>/dev/null", function(result)
    if not result or result == "" or result:find("Unknown") then return end

    local temp, condition = result:match("([^|]+)|?(.*)")
    if not temp then return end

    temp = temp:gsub("[\n\r]", ""):gsub("^%s+", ""):gsub("%s+$", "")
    condition = condition and condition:gsub("[\n\r]", ""):gsub("^%s+", ""):gsub("%s+$", "") or ""

    local icon = "🌡️"
    local condLower = condition:lower()
    for _, entry in ipairs(weatherPatterns) do
      if condLower:find(entry[1]) then
        icon = entry[2]
        break
      end
    end

    weather:set({
      icon = { string = icon },
      label = { string = temp },
    })
  end)
end)
