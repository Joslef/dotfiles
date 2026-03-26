# Memory

## User Environment
- Shell: **fish** — do not use bash-specific syntax (heredocs, `&&` chaining, etc.)
- OS: CachyOS (Arch-based)
- Desktop: Hyprland with SDDM
- AUR helper: paru
- [Extended environment details](project_environment.md) — chezmoi, browser, terminals, Nerd Font

## Superpowers
- [Superpowers skills cheat sheet](superpowers-cheatsheet.md) — buzzwords to trigger each skill; open with `superpowers` command

## Rofi
- Config: `~/.config/rofi/config.rasi`, Theme: `~/.config/rofi/catppuccin-mocha.rasi`
- `highlight` property does not support variable refs (`@var`) — use literal hex colors
- `window {}` block inside `configuration {}` is invalid — window sizing belongs in the theme file
- Font set in `configuration {}` as `font: "JetBrainsMonoNF-Regular 15";`
- Keybindings: Ctrl+H/L for tab switching (freed from kb-remove-char-back / kb-mode-complete)

## Waybar
- [Waybar config details](project_waybar.md) — workspace icons, window-rewrite classes, CSS, scratchpad setup
- [Waybar editing safety](feedback_waybar.md) — how to safely edit config files without truncation
