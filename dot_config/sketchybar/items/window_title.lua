local constants = require("constants")
local settings = require("config.settings")

local windowTitle = sbar.add("item", "window_title", {
  position = "left",
  icon = { drawing = false },
  label = {
    font = {
      family = settings.fonts.text,
      style = settings.fonts.styles.regular,
      size = 12.0,
    },
    color = settings.colors.dirty_white,
    max_chars = 50,
    padding_left = 10,
  },
  background = { color = settings.colors.transparent },
})

local function updateTitle()
  sbar.exec(
    "aerospace list-windows --focused --format %{window-title}",
    function(title)
      title = title:gsub("[\n\r]", "")
      if title == "" then title = "—" end
      windowTitle:set({ label = { string = title } })
    end
  )
end

windowTitle:subscribe(constants.events.FRONT_APP_SWITCHED, updateTitle)
windowTitle:subscribe(constants.events.UPDATE_WINDOWS, updateTitle)

updateTitle()
