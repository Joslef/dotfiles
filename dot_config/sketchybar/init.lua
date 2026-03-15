require("install.sbar")

sbar = require("sketchybar")

sbar.begin_config()
sbar.hotload(true)

require("constants")
require("config.settings")
require("bar")
require("default")
require("items")

sbar.end_config()

-- Initial refresh for todoist, brew, and weather after a short delay
-- to allow launchd agents to populate cache files first
sbar.exec("sleep 30 && sketchybar --update && sketchybar --trigger display_change")

sbar.event_loop()
