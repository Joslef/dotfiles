# 🏠 dotfiles

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/) with OS-conditional deployment for macOS and CachyOS/Arch Linux.

## 🗂️ Overview

This repository is the single source of truth for all personal configuration files across two operating systems. [chezmoi](https://www.chezmoi.io/) handles templating and deployment — the `.chezmoiignore` file uses Go templates to conditionally apply configs based on the detected OS, so macOS-only tools never land on Linux and vice versa.

## 🛠️ Services

### Cross-platform

| Service | Description | Link |
|---------|-------------|------|
| [Ghostty](https://ghostty.org/) | **Ghostty** — fast, native GPU-accelerated terminal emulator | [ghostty.org](https://ghostty.org/) |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | **Kitty** — GPU-based terminal emulator | [kovidgoyal.net/kitty](https://sw.kovidgoyal.net/kitty/) |
| [Neovim](https://neovim.io/) | **Neovim** — hyperextensible Vim-based text editor; config lives in a separate repo | [Joslef/nvim](https://github.com/Joslef/nvim) |
| [btop](https://github.com/aristocratos/btop) | **btop** — resource monitor showing CPU, memory, disks, network, and processes | [GitHub](https://github.com/aristocratos/btop) |
| [Lazygit](https://github.com/jesseduffield/lazygit) | **Lazygit** — terminal UI for git commands | [GitHub](https://github.com/jesseduffield/lazygit) |
| [Yazi](https://github.com/sxyazi/yazi) | **Yazi** — blazing fast terminal file manager | [GitHub](https://github.com/sxyazi/yazi) |
| [spotify-player](https://github.com/aome510/spotify-player) | **spotify-player** — terminal Spotify client with full playback control | [GitHub](https://github.com/aome510/spotify-player) |
| [Claude Code](https://claude.ai/code) | **Claude Code** — Anthropic's CLI coding assistant; settings, agents, hooks, keybindings, and memory | [Docs](https://claude.ai/code) |

### macOS only

| Service | Description | Link |
|---------|-------------|------|
| [Fish shell](https://fishshell.com/) | **Fish** — modern interactive shell with autosuggestions and syntax highlighting | [fishshell.com](https://fishshell.com/) |
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | **AeroSpace** — i3-like tiling window manager for macOS | [GitHub](https://github.com/nikitabobko/AeroSpace) |
| [SketchyBar](https://github.com/FelixKratz/SketchyBar) | **SketchyBar** — highly customizable macOS status bar replacement | [GitHub](https://github.com/FelixKratz/SketchyBar) |
| [JankyBorders](https://github.com/FelixKratz/JankyBorders) | **JankyBorders** — window border highlights for macOS | [GitHub](https://github.com/FelixKratz/JankyBorders) |
| [Karabiner-Elements](https://karabiner-elements.pqrs.org/) | **Karabiner-Elements** — keyboard customizer for macOS | [pqrs.org](https://karabiner-elements.pqrs.org/) |
| LaunchAgents | **LaunchAgents** — macOS scheduled services (under `private_Library/LaunchAgents`) | — |

### Linux (CachyOS) only

| Service | Description | Link |
|---------|-------------|------|
| [Hyprland](https://hyprland.org/) | **Hyprland** — dynamic tiling Wayland compositor | [hyprland.org](https://hyprland.org/) |
| [Waybar](https://github.com/Alexays/Waybar) | **Waybar** — highly customizable Wayland bar | [GitHub](https://github.com/Alexays/Waybar) |
| [Rofi](https://github.com/davatorium/rofi) | **Rofi** — application launcher and window switcher | [GitHub](https://github.com/davatorium/rofi) |
| [nwg-displays](https://github.com/nwg-piotr/nwg-displays) | **nwg-displays** — monitor layout configuration tool for Wayland | [GitHub](https://github.com/nwg-piotr/nwg-displays) |
| [CachyOS](https://cachyos.org/) | **CachyOS** — CachyOS-specific system configs (hello, pi) | [cachyos.org](https://cachyos.org/) |

## 🤖 Claude Code

The `dot_claude/` directory deploys a full Claude Code configuration to `~/.claude`, including:

- **settings.json** — global preferences and permissions
- **agents/** — custom subagents: `code-reviewer`, `documentation-writer`, `refactor-agent`, `root-cause-debugger`, `test-writer`
- **hooks/** — shell hooks that run before/after Claude Code operations
- **keybindings.json** — custom keyboard shortcuts
- **executable_claude_statusbar** / **statusline-command.sh** — status line integration
- **agent-memory/** — persistent memory files for each subagent, carried across sessions

## 📁 Repo Structure

chezmoi maps its source directory names to their target paths on disk:

```
dot_claude/          → ~/.claude            (Claude Code config)
dot_config/          → ~/.config/*          (app configs)
private_Library/     → ~/Library            (macOS LaunchAgents)
.chezmoiignore       → OS-conditional file filtering via Go templates
```

The `private_` prefix tells chezmoi to deploy with restricted permissions (`0600` for files, `0700` for directories). The `.chezmoiignore` file excludes Linux-only configs on macOS and vice versa.

## 🔗 Related Repos

| Repo | Description |
|------|-------------|
| [Joslef/scripts](https://github.com/Joslef/scripts) | Shell scripts and tools |
| [Joslef/nvim](https://github.com/Joslef/nvim) | Neovim configuration |
| [Joslef/macOS_homebrewlist](https://github.com/Joslef/macOS_homebrewlist) | Homebrew package backup |
| [Joslef/CachyOS_pkglist](https://github.com/Joslef/CachyOS_pkglist) | Arch/CachyOS package backup |

## 🚀 Installation

Initialize and apply the dotfiles in one step:

```bash
chezmoi init --apply Joslef
```

This clones the repo into chezmoi's source directory (`~/.local/share/chezmoi`) and immediately deploys all configs appropriate for the current OS.
