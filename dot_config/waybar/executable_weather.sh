#!/bin/bash
data=$(curl -s --max-time 5 \
  'https://api.open-meteo.com/v1/forecast?latitude=48.1351&longitude=11.5820&current_weather=true&hourly=relativehumidity_2m&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum&wind_speed_unit=kmh&timezone=Europe%2FBerlin')

temp=$(echo "$data" | jq -r '.current_weather.temperature')
code=$(echo "$data" | jq -r '.current_weather.weathercode')
wind=$(echo "$data" | jq -r '.current_weather.windspeed')
tmax=$(echo "$data" | jq -r '.daily.temperature_2m_max[0]')
tmin=$(echo "$data" | jq -r '.daily.temperature_2m_min[0]')
precip=$(echo "$data" | jq -r '.daily.precipitation_sum[0]')
humidity=$(echo "$data" | jq -r '.hourly.relativehumidity_2m[0]')
tmax_tomorrow=$(echo "$data" | jq -r '.daily.temperature_2m_max[1]')
tmin_tomorrow=$(echo "$data" | jq -r '.daily.temperature_2m_min[1]')
precip_tomorrow=$(echo "$data" | jq -r '.daily.precipitation_sum[1]')
code_tomorrow=$(echo "$data" | jq -r '.daily.weathercode[1]')

case $code in
  0)          icon="☀️"  ; desc="Clear sky"       ;;
  1|2)        icon="🌤️"  ; desc="Partly cloudy"   ;;
  3)          icon="☁️"  ; desc="Overcast"         ;;
  45|48)      icon="🌫️"  ; desc="Foggy"            ;;
  51|53|55)   icon="🌦️"  ; desc="Drizzle"          ;;
  61|63|65)   icon="🌧️"  ; desc="Rain"             ;;
  71|73|75)   icon="🌨️"  ; desc="Snow"             ;;
  77)         icon="🌨️"  ; desc="Snow grains"      ;;
  80|81|82)   icon="🌦️"  ; desc="Rain showers"     ;;
  85|86)      icon="🌨️"  ; desc="Snow showers"     ;;
  95|96|99)   icon="⛈️"  ; desc="Thunderstorm"     ;;
  *)          icon="❓"  ; desc="Unknown"           ;;
esac

case $code_tomorrow in
  0)          icon_tomorrow="☀️"  ; desc_tomorrow="Clear sky"       ;;
  1|2)        icon_tomorrow="🌤️"  ; desc_tomorrow="Partly cloudy"   ;;
  3)          icon_tomorrow="☁️"  ; desc_tomorrow="Overcast"         ;;
  45|48)      icon_tomorrow="🌫️"  ; desc_tomorrow="Foggy"            ;;
  51|53|55)   icon_tomorrow="🌦️"  ; desc_tomorrow="Drizzle"          ;;
  61|63|65)   icon_tomorrow="🌧️"  ; desc_tomorrow="Rain"             ;;
  71|73|75)   icon_tomorrow="🌨️"  ; desc_tomorrow="Snow"             ;;
  77)         icon_tomorrow="🌨️"  ; desc_tomorrow="Snow grains"      ;;
  80|81|82)   icon_tomorrow="🌦️"  ; desc_tomorrow="Rain showers"     ;;
  85|86)      icon_tomorrow="🌨️"  ; desc_tomorrow="Snow showers"     ;;
  95|96|99)   icon_tomorrow="⛈️"  ; desc_tomorrow="Thunderstorm"     ;;
  *)          icon_tomorrow="❓"  ; desc_tomorrow="Unknown"           ;;
esac

text="$icon ${temp}°C"
tooltip="Munich — $desc\n🌡️  Now: ${temp}°C  (↑${tmax}°C  ↓${tmin}°C)\n💧 Humidity: ${humidity}%\n💨 Wind: ${wind} km/h\n🌂 Precipitation: ${precip} mm\n\nTomorrow — $icon_tomorrow $desc_tomorrow\n🌡️  ↑${tmax_tomorrow}°C  ↓${tmin_tomorrow}°C\n🌂 Precipitation: ${precip_tomorrow} mm"

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
