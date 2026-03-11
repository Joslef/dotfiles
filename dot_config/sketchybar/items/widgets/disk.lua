local settings = require("config.settings")

local disk = sbar.add("item", "widgets.disk", {
  position = "right",
  update_freq = 600,
  icon = {
    string = "󰋊",
    color = settings.colors.blue,
    padding_left = 5,
    padding_right = 4,
  },
  label = {
    string = "??%",
    font = settings.fonts.label(),
  },
})

disk:subscribe({ "routine", "forced" }, function()
  sbar.exec("diskutil info / | awk -F': +' '/Container Total Space/{total=$2} /Container Free Space/{free=$2} END{gsub(/ .*/,\"\",total); gsub(/ .*/,\"\",free); printf \"%.0f%%\", 100*(total-free)/total}'", function(result)
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
