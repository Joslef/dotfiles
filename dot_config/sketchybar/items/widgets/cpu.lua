local constants = require("constants")
local settings = require("config.settings")

local cpu = sbar.add("item", "widgets.cpu", {
  position = "right",
  update_freq = 10,
  icon = {
    string = settings.icons.text.cpu,
    color = settings.colors.cyan,
    padding_right = 4,
  },
  label = {
    string = "??%",
    font = settings.fonts.label(),
  },
})

local mem = sbar.add("item", "widgets.mem", {
  position = "right",
  update_freq = 10,
  icon = {
    string = "󰍛",
    color = settings.colors.purple,
    padding_right = 4,
  },
  label = {
    string = "??%",
    font = settings.fonts.label(),
  },
})

cpu:subscribe({ "routine", "forced" }, function()
  sbar.exec("top -l 1 -n 0 -s 0 | awk '/CPU usage/{printf \"%.0f\", $3+$5}'", function(result)
    local val = tonumber(result) or 0
    local color = settings.colors.white
    if val > 80 then
      color = settings.colors.red
    elseif val > 50 then
      color = settings.colors.orange
    end
    cpu:set({
      label = { string = result .. "%", color = color },
    })
  end)
end)

mem:subscribe({ "routine", "forced" }, function()
  sbar.exec(
    "memory_pressure | awk '/free percentage/{printf \"%.0f\", 100-$5}'",
    function(result)
      local val = tonumber(result) or 0
      local color = settings.colors.white
      if val > 80 then
        color = settings.colors.red
      elseif val > 60 then
        color = settings.colors.orange
      end
      mem:set({
        label = { string = result .. "%", color = color },
      })
    end
  )
end)

sbar.add("item", { position = "right", width = 5 })
