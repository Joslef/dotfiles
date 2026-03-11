# Sketchybar Project Memory

## Setup
- macOS 15.7.4 (Sequoia), Apple Silicon
- Sketchybar installed via Homebrew from HEAD (`felixkratz/formulae/sketchybar`)
- Config: `~/.config/sketchybar/` (Lua-based, uses `sketchybarrc` → `init.lua`)
- Managed by chezmoi (source: `~/.local/share/chezmoi/dot_config/sketchybar/`)
- Uses aerospace for window management
- Two LG monitors: LG Ultra HD + LG HDR 4K, optional Sidecar display

## Key Findings & Fixes

### SkyLight WindowManagement Error (2026-03)
- **Symptom**: sketchybar process runs (responds to queries) but 0 windows, bar invisible
- **Log**: `Unable to bridge WindowManagement interface - no delegate has been set`
- **Cause**: macOS 15.7.4 broke stable sketchybar 2.23.0's SkyLight API usage
- **Fix**: `brew uninstall sketchybar && brew install --HEAD sketchybar`
- **Also needed**: Re-grant Screen Recording permission in System Settings (old TCC entries tied to old Cellar path)
- After brew version changes, always check TCC permissions — they're path-specific

### Display Configuration
- `display=0` (all displays) is broken — bar disappears
- Must use explicit display numbers: `display=1,2`
- `bar.lua` dynamically builds display list from `aerospace list-monitors`
- Excludes Sidecar display when connected
- Falls back to `display=1,2` if aerospace unavailable

### brew outdated Crashes in Sketchybar Sandbox
- `brew outdated` fails inside sketchybar's `sbar.exec` with: `undefined method 'success?' for nil` at `Hardware::CPU.cores`
- Root cause: `getconf _NPROCESSORS_ONLN` subprocess fails in sketchybar's restricted environment
- **Fix**: Separate launchd job (`com.sketchybar.brew-outdated`) writes count to `/tmp/sketchybar_brew_count`, widget reads the file
- Plist at: `~/Library/LaunchAgents/com.sketchybar.brew-outdated.plist`

### Widget `updates` Property
- Default is `updates = "when_shown"` — routine events DON'T fire when `drawing = false`
- Now playing widget needed `updates = "on"` since it starts hidden and shows itself when media plays

## Widget Poll Rates
| Widget | Rate | Method |
|--------|------|--------|
| CPU | 10s | `top -l 1 -n 0 -s 0` (instant single sample) |
| Memory | 10s | `memory_pressure` (lightweight kernel read) |
| Now Playing | 10s | mpv socket / Spotify osascript / nowplaying-cli |
| Calendar | 30s | `os.date()` (no shell exec) |
| Next Event | 60s | reads `/tmp/sketchybar_next_event` file |
| Disk | 600s | shell command |
| Weather | 900s | `curl wttr.in` |
| Brew | 3600s | reads `/tmp/sketchybar_brew_count` file |
| Volume | event-driven | no polling |

## Performance Notes
- Old CPU command `top -l 2 -s 1` took 2 seconds per poll — replaced with `top -l 1 -s 0` (instant)
- `sbar.exec` is async, doesn't block event loop
- File reads (brew, next_event) are cheaper than spawning subprocesses
- Weather uses pattern-based icon matching (case-insensitive keyword search) instead of exact string lookup

## Bar Appearance
- Background: `0x40cccccc` (light grey, 25% opacity) with `blur_radius = 30`
- Corner radius: 9, y_offset: 4, margin: 10
- Font colors: white (`0xfff8f8f2`) for all labels including window title and now playing
- Menu toggle removed — spaces always visible
- Lead padding before first workspace: 20px

## Aerospace Window Rules
| App | Workspace | Rule |
|-----|-----------|------|
| Raycast | (any) | floating + resize script |
| Ghostty | 1 | auto-move |
| Finder | 2 | auto-move |
| Zen Browser | 4 | auto-move |
| Notion | 5 | auto-move |
| Spotify | 7 (Sidecar) / current | conditional — only moves when Sidecar connected |

### Raycast AI Chat Window — Known Limitations
- Raycast has its own internal window management that overrides external size/position changes
- `NSWindow Frame ai-chat-window` in `com.raycast.macos` defaults controls the saved frame, but Raycast overwrites it on every window close/hide
- AppleScript `set size` works momentarily but Raycast resets it after a few focus changes
- macOS Sequoia edge tiling is disabled (`EnableTilingByEdgeDrag = 0`) but Raycast still snaps to edges on its own
- Window snaps to available space minus menu bar (e.g. 1280x1359 instead of 1280x1440)
- `on-window-detected` with `layout floating` works — window IS floating in aerospace, but Raycast controls the size internally
- **Conclusion**: Fighting Raycast's window manager is fragile. Accept its default behavior or file a Raycast feature request for AI Chat window size settings.
- Neither yabai nor Hammerspoon are installed; those would be needed for true always-on-top and forced sizing
- Current setup: `float-raycast-ai.sh` runs on focus change, resizes to 1280x1440, but Raycast may override

## File Structure
- `bar.lua` — bar config + display management
- `items/init.lua` — loads: apple, spaces, front_apps, message, widgets
- `items/widgets/` — individual widget files
- `bridge/` — compiled helpers (menus, network_load, next_event)
- `config/` — colors, dimens, fonts, icons, settings
