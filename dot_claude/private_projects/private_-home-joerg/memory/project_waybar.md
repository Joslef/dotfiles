---
name: Waybar configuration
description: Details of the custom Waybar setup built during session on 2026-03-19
type: project
---

Waybar config lives in `~/.config/waybar/` (tracked by chezmoi):
- `config.jsonc` — module config
- `style.css` — styling

## Center: hyprland/workspaces
- Format: `"<span size='small' color='#888888'>{icon} </span>{windows}"`
- `{icon}` shows workspace number (1–10) from `format-icons`; falls back to `""` via `"default": ""`
- `{windows}` shows per-window Nerd Font icons via `window-rewrite`
- Active workspace: `#FF27DD` border + glow (`box-shadow: 0 0 6px #FF27DD`)
- Inactive workspaces: `rgba(180, 180, 180, 0.6)` border
- `show-special: true` — scratchpad (`special:term`) shows as normal workspace button
- `persistent-workspaces: {"*": 2}`

## Window-rewrite class names (verified real WM classes)
- `kitty` → cat icon (f011b)
- `com.mitchellh.ghostty` / `ghostty` → ghostty icon (f02a0)
- `zen-twilight` → firefox icon
- `org.kde.dolphin` → folder icon
- `org.telegram.desktop` → telegram icon
- `org.pulseaudio.pavucontrol` → volume icon
- `teams-for-linux` → teams icon (f02bb)
- `Bitwarden` → lock icon
- `Raindrop.io` → raindrop icon
- `nwg-displays` → monitor icon (f26c)
- `TelegramDesktop` + `telegram-desktop` + `org.telegram.desktop` all mapped

## Scratchpad (special:term)
- Bound to Super+` in Hyprland (`togglespecialworkspace, term`)
- Launched via: `exec-once = [workspace special:term silent] kitty`
- Shows as normal workspace button (no special CSS treatment)
- No number prefix (no "term" entry in format-icons, falls back to "default": "")

## Key CSS (style.css)
- Workspace button labels: `font-size: 25px; padding: 0 3px`
- Button padding: `4px 9px 4px 5px` (right intentionally larger for visual balance)
- Scratchpad button: `padding-left: 0px; padding-right: 12px`
- Button margin: `0 4px`
- No background pill on `#workspaces`

## Hyprland border (unchanged/original)
- `col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg`
- `col.inactive_border = rgba(595959aa)`

## Waybar restart command
```fish
pkill waybar; sleep 1; WAYLAND_DISPLAY=wayland-1 waybar &disown
```

## Chezmoi
All waybar files tracked. Use `chezmoi re-add ~/.config/waybar/config.jsonc ~/.config/waybar/style.css` to sync changes.
