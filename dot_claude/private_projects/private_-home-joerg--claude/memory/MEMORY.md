# Memory

## Waybar
- Config: `~/.config/waybar/config.jsonc`
- Version: v0.15.0
- **mpris module**: `{dynamic}` and `dynamic-order` are NOT supported in v0.15.0 — use `{title}`, `{artist}`, `{album}` only. Using unsupported options causes a crash (core dump) when a new MPRIS player connects.
- mpv radio is shown via `mpv-mpris` package (installed). mpv icon: `󰐻`, player key: `"mpv"`.
- Reload: `pkill -SIGUSR2 waybar` (must run in the compositor session, not a Claude shell).

## System
- OS: CachyOS (Arch-based), shell: fish
- WM: Hyprland
- No `socat` or `nc` installed; Python3 socket available as fallback for IPC.
- `playerctl` installed at `/usr/bin/playerctl`.
