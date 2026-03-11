#!/bin/bash
# Resize Raycast AI Chat to left half of LG HDR (1280x1440) and pin on top
app=$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)
[ "$app" = "Raycast" ] || exit 0

title=$(aerospace list-windows --focused --format '%{window-title}' 2>/dev/null)
[ "$title" = "AI Chat" ] || exit 0

osascript -e '
tell application "System Events"
    tell process "Raycast"
        tell window "AI Chat"
            set size to {1280, 1440}
            set frontmost of process "Raycast" to true
        end tell
    end tell
end tell
' 2>/dev/null &
