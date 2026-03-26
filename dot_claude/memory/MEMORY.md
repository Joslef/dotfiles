# 🧠 Global Memory

## 🔄 Memory Update Loop

After finishing any task, always run the End-of-Session Memory Loop. Announce it with `** **UPDATING MEMORY LOOP** **`.

1. **Session learnings** — write ALL new insights, corrections, or findings into `~/.claude/memory/MEMORY.md` under the appropriate section. NEVER write to project-specific memory files (`.claude/projects/`) — always use the global file.
2. **Memory review** — read all sections: shorten verbose entries, remove irrelevant content, deduplicate. Be conservative — memory should grow first, only trim what is clearly redundant or no longer applicable.

---

## 👤 User Profile

- **Name**: Joerg
- **Primary machine**: CachyOS Linux (daily driver)
- **Secondary machine**: macOS (legacy/work)
- **Dotfiles**: managed with **chezmoi** (except `~/scripts` — synced via git: Joslef/scripts)
  - `dot_` prefix → `.` prefix; `private_` prefix → restricted permissions (0600/0700)
  - `.chezmoiignore` uses Go templates: `{{ if ne .chezmoi.os "linux" }}` for OS-conditional deployment

---

## 🖥️ Environment

### Linux

- **Shell**: fish — never use bash-specific syntax (no heredocs, no `&&`/`||` chaining outside fish syntax, no `[[ ]]`)
- **OS**: CachyOS (Arch-based), AUR helper: paru
- **Desktop**: Hyprland + SDDM
- **Font**: JetBrainsMono Nerd Font (confirmed in rofi)
- **Mouse**: Logitech MX Master 3 — solaar/wlrctl removed, no DPI tooling; use Hyprland mousemode submap (`SUPER+M`) for keyboard-driven scrolling via ydotool
- **Hyprland notes**: `wlrctl` segfaults on this system; `wtype` cannot release physically-held modifiers (Super bleeds into keystrokes when used in `bind exec`); mousemode submap is the reliable approach for mouse emulation

### macOS (legacy)

- **Shell**: fish (macOS-only, excluded on Linux via chezmoi)
- **WM**: AeroSpace
- **Bar**: Sketchybar (Lua-based, Homebrew HEAD)
- **Monitors**: LG Ultra HD (secondary) + LG HDR 4K (main) + optional Sidecar (iPad)

---

## ⚙️ Behavior Rules

### 🎉 Emojis

Use emojis freely and enthusiastically in all responses — the more the merrier! 😄
Sprinkle them throughout without restraint. 🚀✨

### ✂️ Conciseness

Concise responses — skip preamble and summaries. Confirm before making edits when asked to do so.

### 🧠 Memory Load Confirmation

At the start of every session, include `** **GLOBAL MEMORY LOADED** **` in the first response to confirm the memory injection was successful. Skip this on `q:` sessions.

### ⚡ Quick Questions

If the session starts with `q:` — no memory writes, no end-of-session loop.

### 🐟 Fish Shell

Never use bash-specific syntax. No heredocs, no `&&`/`||` chaining outside fish syntax, no `[[ ]]`.

### 📁 Chezmoi Sync

Only files under `~/.config` need chezmoi attention. After any session involving `~/.config` changes:

- Run a sync check: verify all user-tracked `~/.config` files are in sync with chezmoi
- If a tracked file was changed: **actually run** `chezmoi re-add <path>` — do not just suggest it to the user
- Never prompt to add untracked files — the user decides what is tracked

`~/.claude` is synced via a separate user script — do NOT chezmoi re-add anything under `~/.claude`.
`~/scripts` is git-managed — do NOT chezmoi anything there either.

---

## 🍎 macOS Config

### AeroSpace

- Config: `~/.config/aerospace/aerospace.toml`, helpers in `~/.config/aerospace/`
- Known limitation: floating window positioning unreliable on secondary monitors — [issue #1519](https://github.com/nikitabobko/AeroSpace/issues/1519)
- Ghostty new windows: use AppleScript Cmd+N approach, NOT direct binary launch (causes multiple dock icons)

### Sketchybar

- Installed via Homebrew HEAD (`felixkratz/formulae/sketchybar`)
- Config: `~/.config/sketchybar/` (Lua-based, `sketchybarrc` → `init.lua`)
- **SkyLight fix**: macOS 15.7.4 broke stable sketchybar 2.23.0. Fix: `brew uninstall sketchybar && brew install --HEAD sketchybar`. Also re-grant Screen Recording permission (TCC entries are path-specific).
- `display=0` (all displays) is broken — must use explicit `display=1,2`
- `brew outdated` crashes in sketchybar sandbox — use launchd job writing to `/tmp/sketchybar_brew_count`
- `updates = "when_shown"` means routine events don't fire when `drawing = false` — use `updates = "on"` for widgets that start hidden
- After brew version changes, always check TCC permissions — they're path-specific

### Neovim

- Config: `~/.config/nvim/`, keymaps: `~/.config/nvim/lua/config/keymaps.lua`
- `ft` is NOT a valid which-key field — use `cond = function() return vim.bo.filetype == "markdown" end`
- Nerd Font icon copy-paste through Claude terminal loses the character — write via Python: `python3 -c "icon = '\uf48a'; ..."`

---

## 🐚 Shell Script Anti-Patterns

Patterns discovered while reviewing archmaint and macfresh scripts:

- **`ls glob | wc -l` in `$()` under `set -euo pipefail`**: `ls` exits non-zero on no matches, pipefail propagates it, script aborts. Use `find` or `shopt -s nullglob` instead.
- **`brew list | wc -l` and `mas list | wc -l` under pipefail**: `brew` can exit non-zero (network, lock) and `mas` fails if not signed in — both abort mid-script. Fix: append `2>/dev/null || echo 0`.
- **`xargs cmd -- --flag`**: `--` ends option parsing so `--flag` is treated as an argument. Always put flags BEFORE `--`.
- **`grep -qi "error"` on pacman output**: `pacman -Dk` success message "No database errors have been found!" contains "errors" — always false-positive. Match more specifically.
- **`read` under `set -e`**: EOF (Ctrl+D) causes `read` to return non-zero, aborting script. Guard with `read ... || true` in interactive loops.
- **`confirm()` returning non-zero**: only safe inside an `if`-guard — calling it unconditionally aborts under `set -e`.
- **`paccache -r` without sudo**: silently fails — `/var/cache/pacman/pkg/` is root-owned. Always prefix with `sudo`.
- **`mas outdated` exits 1** when no updates exist — aborts under `set -e`. Guard with `|| true`.
- **Unquoted globs in `rm -rf`**: e.g. `rm -rf ~/Library/Caches/*` — quote or use find to avoid glob expansion issues.
- **`$EPOCHREALTIME` locale bug**: uses system locale decimal separator (comma on DE/EU). Normalize before arithmetic: `${EPOCHREALTIME/,/.}`.

---

## 📝 Scripts README Style

Confirmed across archmaint, gitstatus, pkgsync, dotfiles READMEs:

- **Title**: `# <emoji> toolname` — one emoji, lowercase tool name
- **Tagline**: single sentence immediately under title, no heading
- **`## ✨ Features`**: bullet list, each entry: `<emoji> **Bold Label** — em-dash description`
- **`## 🚀 Usage`**: bash code blocks; interactive invocation first, then flags/modes
- **`## 📋 Menu Options`**: markdown table, columns: Option | Action; options in backtick code spans
- **`## 📦 Dependencies`**: flat bullet list; note optional deps and fallbacks
- **`## 🔧 Installation`**: bash code block with `cp` + `chmod +x`; add auth/setup steps before first run
- **`## 🖥️ Requirements`**: short bullet list: OS, shell version, runtime constraints
- **Tone**: direct, present tense, active voice; concise but complete
- **All `##` headings carry an emoji**
- **READMEs live alongside the script** in each tool's subdirectory under `~/scripts/` — no separate `/docs`
- **Service/tool tables**: columns are `Service | Description | Link`; bold tool name inside Description: `**Name** — em-dash description`

---

## 🎵 audioshell Architecture

- Lua script injected into mpv via `--script=` to observe `media-title` / `artist` properties
- Metadata written to `/tmp/audioshell_meta_$$`, read on each event loop iteration
- Pause/resume: `SIGSTOP`/`SIGCONT` on mpv PID (no IPC, no reconnect on resume)
- Animation: `$EPOCHREALTIME` at ~3fps (bash 5+), falls back to `$SECONDS` at 1fps (bash 3.2/macOS)
- macOS compat: integer-only `read -t` on bash 3.2, detected via `$BASH_VERSION`

---

## 🔌 Claude Code Plugin System

Plugin state lives in three places:
- `~/.claude/plugins/installed_plugins.json` — installed plugin registry
- `~/.claude/plugins/cache/<marketplace>/<plugin>/` — downloaded plugin files
- `~/.claude/plugins/data/<plugin>-<marketplace>/` — plugin runtime data

**swift-lsp auto-resurrection**: CC re-adds `swift-lsp@claude-plugins-official` on every startup because `~/.claude.json` contains a server-fetched feature flag list that includes it. This list is Anthropic-controlled and cannot be permanently removed. **Solution**: just leave it `disabled` in `/plugin` UI — it does nothing when disabled. Don't waste time trying to purge it.
