---
name: User Profile
description: Who the user is, their environment, and general preferences across all projects
type: user
---

## Identity
- Name: Joerg
- Uses both **CachyOS Linux** (primary, daily driver) and **macOS** (legacy/work)

## Linux Environment
- Shell: **fish** — never use bash-specific syntax (heredocs, `&&` chaining, `[[ ]]`)
- OS: CachyOS (Arch-based), AUR helper: paru
- Desktop: Hyprland + SDDM
- Nerd Font in use (JetBrainsMono Nerd Font confirmed for rofi)

## macOS Environment (legacy)
- Shell: fish (macOS-only, excluded on Linux via chezmoi)
- WM: AeroSpace
- Bar: Sketchybar (Lua-based, Homebrew HEAD)
- Monitors: LG Ultra HD (secondary) + LG HDR 4K (main) + optional Sidecar (iPad)

## General Preferences
- No emojis in responses unless explicitly requested
- Concise responses — skip preamble and summaries
- Confirm before making edits when asked
- Dotfiles managed with **chezmoi** (except `~/scripts` — synced via git: Joslef/scripts)
