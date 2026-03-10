local settings = require("config.settings")

local weatherIcons = {
  ["Clear"] = "☀️",
  ["Sunny"] = "☀️",
  ["Partly cloudy"] = "⛅",
  ["Cloudy"] = "☁️",
  ["Overcast"] = "☁️",
  ["Mist"] = "🌫️",
  ["Fog"] = "🌫️",
  ["Patchy rain possible"] = "🌦️",
  ["Light rain"] = "🌧️",
  ["Moderate rain"] = "🌧️",
  ["Heavy rain"] = "🌧️",
  ["Light drizzle"] = "🌦️",
  ["Patchy light rain"] = "🌦️",
  ["Light snow"] = "🌨️",
  ["Moderate snow"] = "🌨️",
  ["Heavy snow"] = "❄️",
  ["Thunderstorm"] = "⛈️",
  ["Patchy snow possible"] = "🌨️",
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
    font = {
      family = settings.fonts.text,
      style = settings.fonts.styles.regular,
      size = 12.0,
    },
  },
})

weather:subscribe({ "routine", "forced" }, function()
  sbar.exec("curl -s 'wttr.in/?format=%t|%C' 2>/dev/null", function(result)
    if not result or result == "" or result:find("Unknown") then return end

    local temp, condition = result:match("([^|]+)|?(.*)")
    if not temp then return end

    temp = temp:gsub("[\n\r]", ""):gsub("^%s+", ""):gsub("%s+$", "")
    condition = condition and condition:gsub("[\n\r]", ""):gsub("^%s+", ""):gsub("%s+$", "") or ""

    local icon = weatherIcons[condition] or "🌡️"

    weather:set({
      icon = { string = icon },
      label = { string = temp },
    })
  end)
end)
