local constants = require("constants")
local settings = require("config.settings")

local frontApps = {}

sbar.add("item", "spaces_apps_gap", { width = 0 })
sbar.add("bracket", constants.items.FRONT_APPS, {}, { position = "left" })

local frontAppWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

local function selectFocusedWindow(frontAppName)
  for appName, app in pairs(frontApps) do
    local isSelected = appName == frontAppName
    local color = isSelected and settings.colors.orange or settings.colors.white
    app:set(
      {
        label = { color = color },
        icon = { color = color },
      }
    )
  end
end

local function updateWindows(windows)
  sbar.remove("/" .. constants.items.FRONT_APPS .. "\\.*/")

  frontApps = {}
  local foundWindows = string.gmatch(windows, "[^\n]+")
  for window in foundWindows do
    local parsedWindow = {}
    for key, value in string.gmatch(window, "(%w+)=([%w%s]+)") do
      parsedWindow[key] = value
    end

    local windowId = parsedWindow["id"]
    local windowName = parsedWindow["name"]
    local icon = settings.icons.apps[windowName] or settings.icons.apps["default"]

    frontApps[windowName] = sbar.add("item", constants.items.FRONT_APPS .. "." .. windowName, {
      label = {
        padding_left = 0,
        string = windowName,
      },
      icon = {
        string = icon,
        font = settings.fonts.icons(),
        padding_left = 25,
      },
      click_script = "aerospace focus --window-id " .. windowId,
    })

    frontApps[windowName]:subscribe(constants.events.FRONT_APP_SWITCHED, function(env)
      selectFocusedWindow(env.INFO)
    end)
  end

  -- Add window title right after the app items
  sbar.exec(constants.aerospace.GET_CURRENT_WINDOW, function(frontAppName)
    frontAppName = frontAppName:gsub("[\n\r]", "")
    selectFocusedWindow(frontAppName)

    sbar.exec(
      "aerospace list-windows --focused --format %{window-title}",
      function(title)
        title = title:gsub("[\n\r]", "")
        if title ~= "" then
          sbar.add("item", constants.items.FRONT_APPS .. ".window_title", {
            icon = {
              string = "│",
              color = settings.colors.grey,
              padding_left = 8,
              padding_right = 10,
              font = settings.fonts.label(14.0),
            },
            label = {
              string = title,
              color = settings.colors.white,
              max_chars = 80,
              font = settings.fonts.label(),
            },
          })
        end
      end
    )
  end)
end

local function getWindows()
  sbar.exec(constants.aerospace.LIST_WINDOWS, updateWindows)
end

frontAppWatcher:subscribe(constants.events.UPDATE_WINDOWS, function()
  getWindows()
end)

getWindows()
