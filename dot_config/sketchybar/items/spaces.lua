local constants = require("constants")
local settings = require("config.settings")

local spaces = {}

local swapWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

-- Add a group separator after workspaces 3 and 6
local groupBreakAfter = { ["3"] = true, ["6"] = true }

-- Workspaces 7-9 only visible when Sidecar monitor is connected
local externalOnly = { ["7"] = true, ["8"] = true, ["9"] = true }

-- All workspace names we create items for
local allWorkspaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

local function updateExternalWorkspaces()
  sbar.exec("aerospace list-monitors", function(monitorsOutput)
    local hasSidecar = monitorsOutput:find("Sidecar") ~= nil
    for sid, item in pairs(spaces) do
      local spaceNum = sid:match("([^.]+)$")
      if externalOnly[spaceNum] then
        item:set({ drawing = hasSidecar })
        sbar.set(sid .. ".padding", { drawing = hasSidecar })
      end
    end
    local sep6 = constants.items.SPACES .. ".6.padding"
    sbar.set(sep6, { drawing = hasSidecar })
  end)
end

-- Query all workspaces once, then set both icon and color for each in one pass
local function refreshWorkspaces()
  sbar.exec("aerospace list-workspaces --focused", function(focusedOut)
    local focusedWorkspaceName = focusedOut:match("[^\r\n]+")
    sbar.exec("aerospace list-windows --all --format '%{workspace}|%{app-name}' 2>/dev/null", function(out)
      -- Parse all windows into a table: wsApps[wsName] = firstAppName
      local wsApps = {}
      for line in out:gmatch("[^\n]+") do
        local ws, app = line:match("([^|]+)|(.+)")
        if ws and app and not wsApps[ws] then
          wsApps[ws] = app
        end
      end
      -- Update all workspace items in one pass
      for _, wsName in ipairs(allWorkspaces) do
        local spaceName = constants.items.SPACES .. "." .. wsName
        local item = spaces[spaceName]
        if item then
          local firstApp = wsApps[wsName]
          local isSelected = wsName == focusedWorkspaceName
          -- Set icon and color together
          if firstApp then
            local appIcon = settings.icons.apps[firstApp] or settings.icons.apps["default"]
            item:set({
              icon = {
                string = appIcon,
                font = settings.fonts.icons(),
                color = isSelected and settings.colors.orange or settings.colors.white,
              },
            })
          else
            -- No app running — show workspace number, dimmed
            item:set({
              icon = {
                string = wsName,
                font = {
                  family = settings.fonts.text,
                  style = settings.fonts.styles.regular,
                  size = settings.dimens.text.icon,
                },
                color = isSelected and settings.colors.orange or settings.colors.grey,
              },
            })
          end
        end
      end
    end)
  end)
end

local firstItem = true

local function addWorkspaceItem(workspaceName)
  local spaceName = constants.items.SPACES .. "." .. workspaceName

  if firstItem then
    sbar.add("item", spaceName .. ".leadpad", { width = 20 })
    firstItem = false
  end

  spaces[spaceName] = sbar.add("item", spaceName, {
    label = { drawing = false },
    icon = {
      string = workspaceName,
      font = {
        family = settings.fonts.text,
        style = settings.fonts.styles.regular,
        size = settings.dimens.text.icon,
      },
      color = settings.colors.grey,
      padding_left = 4,
      padding_right = 4,
    },
    background = {
      color = settings.colors.transparent,
    },
    click_script = "aerospace workspace " .. workspaceName,
  })

  local padWidth = 5
  if groupBreakAfter[workspaceName] then
    padWidth = 28
  end

  sbar.add("item", spaceName .. ".padding", {
    width = padWidth
  })
end

local function createWorkspaces()
  sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
    for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
      addWorkspaceItem(workspaceName)
    end

    refreshWorkspaces()
    updateExternalWorkspaces()
  end)
end

local displayWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

displayWatcher:subscribe("display_change", function(env)
  updateExternalWorkspaces()
end)

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
  local isShowingSpaces = env.isShowingMenu == "off" and true or false
  sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
  refreshWorkspaces()
  sbar.trigger(constants.events.UPDATE_WINDOWS)
end)

createWorkspaces()
