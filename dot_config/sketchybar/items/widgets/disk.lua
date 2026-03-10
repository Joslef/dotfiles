local settings = require("config.settings")

local disk = sbar.add("item", "widgets.disk", {
  position = "right",
  update_freq = 120,
  icon = {
    string = "󰋊",
    color = settings.colors.blue,
    padding_left = 5,
    padding_right = 4,
  },
  label = {
    string = "??%",
    font = {
      family = settings.fonts.numbers,
      style = settings.fonts.styles.regular,
      size = 12.0,
    },
  },
})

disk:subscribe({ "routine", "forced" }, function()
  sbar.exec("df -h / | awk 'NR==2{printf \"%s\", $5}'", function(result)
    local val = tonumber(result:match("(%d+)")) or 0
    local color = settings.colors.white
    if val > 90 then
      color = settings.colors.red
    elseif val > 75 then
      color = settings.colors.orange
    end
    disk:set({
      label = { string = result, color = color },
      icon = { color = val > 90 and settings.colors.red or settings.colors.blue },
    })
  end)
end)
