local settings = require("config.settings")

sbar.exec(
  "killall network_load >/dev/null; $CONFIG_DIR/bridge/network_load/bin/network_load en0 network_update 2.0"
)

sbar.add("item", "widgets.net.pad_r", { position = "right", width = 6 })

local netUp = sbar.add("item", "widgets.net.up", {
  position = "right",
  width = 0,
  icon = {
    padding_left = 0,
    padding_right = 0,
    font = {
      style = settings.fonts.styles.bold,
      size = 10.0,
    },
    string = settings.icons.text.wifi.upload,
  },
  label = {
    font = {
      family = settings.fonts.numbers,
      style = settings.fonts.styles.bold,
      size = 10.0,
    },
    color = settings.colors.orange,
    string = "??? Bps",
  },
  y_offset = 4,
})

local netDown = sbar.add("item", "widgets.net.down", {
  position = "right",
  icon = {
    padding_left = 0,
    padding_right = 0,
    font = {
      style = settings.fonts.styles.bold,
      size = 10.0,
    },
    string = settings.icons.text.wifi.download,
  },
  label = {
    font = {
      family = settings.fonts.numbers,
      style = settings.fonts.styles.bold,
      size = 10,
    },
    color = settings.colors.blue,
    string = "??? Bps",
  },
  y_offset = -4,
})

sbar.add("item", "widgets.net.pad_l", { position = "right", width = 6 })

netUp:subscribe("network_update", function(env)
  local upColor = (env.upload == "000 Bps") and settings.colors.grey or settings.colors.orange
  local downColor = (env.download == "000 Bps") and settings.colors.grey or settings.colors.blue

  netUp:set({
    icon = { color = upColor },
    label = { string = env.upload, color = upColor },
  })
  netDown:set({
    icon = { color = downColor },
    label = { string = env.download, color = downColor },
  })
end)
