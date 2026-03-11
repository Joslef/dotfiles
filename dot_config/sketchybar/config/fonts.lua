local dimens <const> = require("config.dimens")

local _defaultIconFont = "sketchybar-app-font:Regular:" .. dimens.text.icon

return {
  text = "SpaceMono Nerd Font",
  numbers = "SpaceMono Nerd Font",
  icons = function(size)
    if not size then return _defaultIconFont end
    return "sketchybar-app-font:Regular:" .. size
  end,
  label = function(size)
    return {
      family = "SpaceMono Nerd Font",
      style = "Regular",
      size = size or 12.0,
    }
  end,
  styles = {
    regular = "Regular",
    bold = "Bold",
  }
}
