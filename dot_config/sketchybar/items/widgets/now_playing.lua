local settings = require("config.settings")

local npDivider = sbar.add("item", "widgets.now_playing.divider", {
  position = "right",
  icon = {
    string = "│",
    color = settings.colors.grey,
    padding_left = 12,
    padding_right = 14,
    font = {
      family = settings.fonts.text,
      style = settings.fonts.styles.regular,
      size = 14.0,
    },
  },
  label = { drawing = false },
  drawing = false,
})

local npTitle = sbar.add("item", "widgets.now_playing.title", {
  position = "right",
  drawing = false,
  icon = { drawing = false },
  label = {
    font = {
      family = settings.fonts.text,
      style = settings.fonts.styles.regular,
      size = 12.0,
    },
    color = settings.colors.dirty_white,
    max_chars = 60,
    scroll_texts = false,
    padding_left = 0,
    padding_right = 0,
  },
})

local npIcon = sbar.add("item", "widgets.now_playing.icon", {
  position = "right",
  icon = { drawing = false },
  label = { drawing = false },
  drawing = false,
  update_freq = 3,
})

local function showNowPlaying(display)
  npIcon:set({ drawing = true })
  npTitle:set({ drawing = true, label = { string = display } })
  npDivider:set({ drawing = true })
end

local function hideNowPlaying()
  npIcon:set({ drawing = false })
  npTitle:set({ drawing = false })
  npDivider:set({ drawing = false })
end

local function checkSpotify(callback)
  sbar.exec(
    [[osascript -e 'if application "Spotify" is running then' -e 'tell application "Spotify"' -e 'if player state is playing then' -e 'set t to name of current track' -e 'set a to artist of current track' -e 'return a & " — " & t' -e 'end if' -e 'end tell' -e 'end if' -e 'return ""' 2>/dev/null]],
    callback
  )
end

local function updateNowPlaying()
  -- Try mpv IPC socket first
  sbar.exec(
    [[echo '{"command":["get_property","media-title"]}' | socat - /tmp/mpv-socket 2>/dev/null | grep -o '"data":"[^"]*"' | head -1 | sed 's/"data":"//;s/"$//' ]],
    function(mpvTitle)
      mpvTitle = mpvTitle:gsub("[\n\r]", "")
      if mpvTitle ~= "" then
        showNowPlaying(mpvTitle)
        return
      end

      -- Try Spotify directly
      checkSpotify(function(spotifyResult)
        spotifyResult = spotifyResult:gsub("[\n\r]", "")
        if spotifyResult ~= "" then
          showNowPlaying(spotifyResult)
          return
        end

        -- Fallback: macOS Now Playing (Apple Music, etc.)
        sbar.exec("nowplaying-cli get title artist 2>/dev/null", function(result)
          result = result:gsub("[\n\r]+$", "")
          if result == "" then
            hideNowPlaying()
            return
          end

          local lines = {}
          for line in result:gmatch("[^\n]+") do
            if line ~= "null" then
              table.insert(lines, line)
            end
          end
          local title = lines[1] or ""
          local artist = lines[2] or ""

          local display = ""
          if title ~= "" and artist ~= "" then
            display = artist .. " — " .. title
          elseif title ~= "" then
            display = title
          end

          if display ~= "" then
            showNowPlaying(display)
          else
            hideNowPlaying()
          end
        end)
      end)
    end
  )
end

npIcon:subscribe({ "routine", "forced", "media_change" }, updateNowPlaying)

npIcon:subscribe("mouse.clicked", function()
  sbar.exec("nowplaying-cli togglePlayPause 2>/dev/null")
end)

updateNowPlaying()
