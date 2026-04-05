# 🧠 Global Memory

## 1. 🧠 Meta — Claude Instructions

### 1.1 🔄 Memory Rules & Loop

After finishing any task, always run the End-of-Session Memory Loop. Announce it with `** **UPDATING MEMORY LOOP** **`.

⚠️ **MEMORY RULE CONFIRMED** ⚠️
The one and only valid save location for memory is `~/.claude/memory/MEMORY.md`. This is absolute and non-negotiable. Never write to `.claude/projects/` or any other location — not as separate files, not as subdirectories, not ever. If it isn't going into `~/.claude/memory/MEMORY.md` directly, it isn't being saved.

After reading and understanding this rule, confirm with: `** **MEMORY RULE CONFIRMED** **`

1. **Session learnings** — write ALL new insights, corrections, or findings into `~/.claude/memory/MEMORY.md` under the appropriate section. NEVER write to project-specific memory files (`.claude/projects/`) — always use the global file.
2. **Memory review** — read all sections: shorten verbose entries, remove irrelevant content, deduplicate. Be conservative — memory should grow first, only trim what is clearly redundant or no longer applicable.

### 1.2 ⚙️ Session Behavior Rules

#### 1.2.1 🎉 Emojis

Use emojis freely and enthusiastically in all responses — the more the merrier! 😄
Sprinkle them throughout without restraint. 🚀✨

#### 1.2.2 ✂️ Conciseness

Concise responses — skip preamble and summaries. Confirm before making edits when asked to do so.

#### 1.2.3 📋 Copy-Paste Commands

When showing commands the user needs to run themselves, **never prefix them with `!`**. Joerg copies commands directly and the `!` breaks them.

#### 1.2.4 🧠 Memory Load Confirmation

At the start of every session, include `** **GLOBAL MEMORY LOADED** **` in the first response to confirm the memory injection was successful. Skip this on `q:` sessions.

**Statusbar input JSON fields** (confirmed via logging): `session_id`, `transcript_path`, `cwd`, `model` (`id`, `display_name`), `workspace` (`current_dir`, `project_dir`, `added_dirs`), `version`, `output_style`, `cost`, `context_window` (`total_input_tokens`, `total_output_tokens`, `context_window_size`, `current_usage`, `used_percentage`, `remaining_percentage`), `exceeds_200k_tokens`, `rate_limits` (`five_hour`/`seven_day` with `used_percentage` + `resets_at` as epoch), `vim` (`mode`).

**`~/.claude/CLAUDE.md`** exists — enforces memory load confirmation at session start via project instructions (more reliable than memory alone since it's part of the system prompt).

**Hook stdin payload** contains session context including `session_id` — hooks can read it via `$(cat)` before doing other work.

#### 1.2.5 ⚡ Quick Questions

If the session starts with `q:` — no memory writes, no end-of-session loop.

#### 1.2.6 🔍 Unknown Topics → Research First

If Joerg mentions a tool, service, or concept that is unfamiliar or unclear, don't guess or ask — run a web search first, get the facts, then answer. Never respond with "I'm not sure what that is" without first attempting a search.

#### 1.2.7 🤖 Self-Sufficiency

Figure things out independently — read files, search the codebase, run commands, check configs, browse the web. Never ask Joerg to look something up or gather info that can be obtained directly. The only thing Joerg should ever need to do is run `sudo` commands when elevated privileges are required.

#### 1.2.8 🐟 Fish Shell Syntax

Never use bash-specific syntax. No heredocs, no `&&`/`||` chaining outside fish syntax, no `[[ ]]`.

### 1.3 🪄 Spells

Single-word inputs Joerg types to invoke specific behaviors. Execute immediately — don't confirm, don't suggest.

| Spell | Action |
|-------|--------|
| `chezmoi` | **Step 1 — sync `.claude`:** Run `chezclaudesync` first (script at `~/scripts/chezclaudesync/chezclaudesync`). This pulls in any session changes to Claude Code config, memory, agents, hooks etc. into chezmoi. **Step 2 — sync `.config`:** Re-add all session-changed `~/.config` files; add any new ones introduced this session. Cross-check against `chezmoi list`, run `chezmoi re-add` / `chezmoi add` on anything not yet tracked. Never touch `~/.claude` directly or `~/scripts`. **Step 3 — commit & push:** In `~/.local/share/chezmoi`, stage everything, then use AskUserQuestion to present exactly 3 commit message options. Messages must reflect the full picture of what changed — could be only `.claude` files, only `.config` files, or both; the message should give a clear overview of the session's changes as a whole. Style: capital verb, imperative, no period, max 70 chars (e.g. "Add waybar VPN widget", "Update claude code memory and hooks", "Change rofi theme and update claude settings"). After the user picks one, commit and push to the GitHub remote. |
| `loop` | Run the End-of-Session Memory Loop: reflect on session learnings, write new insights to `~/.claude/memory/MEMORY.md`, review all sections for staleness and duplication. Never write to project-specific memory files. |

**Always-on chezmoi rules** (apply every session, not just when the `chezmoi` spell is invoked):

- Only `~/.config` needs chezmoi attention; `~/.claude` goes through `chezclaudesync`; `~/scripts` is git-managed — never chezmoi either
- After any session that touched `~/.config` files: proactively run a sync check — don't wait for the `chezmoi` spell to be invoked
- **Actually run** `chezmoi re-add <path>` / `chezmoi add <path>` — do not just suggest the command to Joerg
- New files affecting look/behavior (cursor, theme, keybindings, bar config, etc.): add without asking — just do it
- Never add auto-generated files, caches, or runtime state

---

## 2. 👤 User Profile

- **Name**: Joerg
- **Primary machine**: CachyOS Linux (daily driver)
- **Secondary machine**: macOS (legacy/work)
- **Dotfiles**: managed with **chezmoi** (except `~/scripts` — synced via git: Joslef/scripts)
  - `dot_` prefix → `.` prefix; `private_` prefix → restricted permissions (0600/0700)
  - `.chezmoiignore` uses Go templates: `{{ if ne .chezmoi.os "linux" }}` for OS-conditional deployment
- **Learning**: Passed **AWS Cloud Practitioner** exam (2026-04); actively exploring AWS services and architecture
- **Interests**: Deeply curious about AWS — enjoys understanding how services interconnect, where the gaps are, and the "why" behind AWS design decisions

---

## 3. 🖥️ Hardware & Environment

### 3.1 🐧 Linux (CachyOS)

#### 3.1.1 ⚙️ System

- **Shell**: fish — never use bash-specific syntax (no heredocs, no `&&`/`||` chaining outside fish syntax, no `[[ ]]`)
- **OS**: CachyOS (Arch-based), AUR helper: paru
- **Desktop**: Hyprland + SDDM
- **Font**: JetBrainsMono Nerd Font (confirmed in rofi)

#### 3.1.2 🖥️ Monitors

- **DP-1** = Display Left (right physically, ID 0); **HDMI-A-1** = Display Right (LG Ultra HD, ID 1) at x=3840
- Both scale=1.0
- Use `hyprctl --batch` for multi-monitor changes to avoid Hyprland misalignment warnings

#### 3.1.3 📡 Streaming (Sunshine)

- Sunshine (LizardByte) running as systemd user service; capture=wlr (Hyprland), encoder=h264_vaapi (AMD RX 6650 XT)
- Requires `LIBVA_DRIVER_NAME=radeonsi` in service env
- Config at `~/.config/sunshine/`
- UFW ports: 47984/47989/47990/48010 tcp + 47998/47999/48000/48002/5353 udp open

### 3.2 🍎 macOS (legacy)

- **Shell**: fish (macOS-only, excluded on Linux via chezmoi)
- **WM**: AeroSpace
- **Bar**: Sketchybar (Lua-based, Homebrew HEAD)
- **Monitors**: LG Ultra HD (secondary) + LG HDR 4K (main) + optional Sidecar (iPad)

### 3.3 🔌 Peripherals

#### 3.3.1 🎧 Bluetooth Audio — WH-1000XM4

- **MAC**: `80:99:E7:2E:99:D4` — old/stale device MAC sometimes in state files: `E8:EE:CC:C5:8F:7E` (remove if found)
- **Volume control**: `~/.config/wireplumber/wireplumber.conf.d/51-bluez-config.conf` must have `bluez5.enable-absolute-volume = true` — `false` breaks system volume slider
- **Auto-switch default sink**: WirePlumber persists default sink in `~/.local/state/wireplumber/default-nodes`; `find-selected-default-node.lua` gives saved node a +30000 priority bonus — stale MAC means headset never wins. Fix: correct the file, then `wpctl set-default <id>` to persist
- **Profile race condition** (upstream bug): log `s-device: Could not find valid non-headset profile, not switching` — fires when A2DP not yet enumerated at connect time; cosmetic once state is correct
- **After wireplumber restart**: headset may reconnect in HFP — fix with `bluetoothctl disconnect` + `bluetoothctl connect` to renegotiate A2DP

---

## 4. 🐧 Linux Desktop

### 4.1 🏞️ Hyprland

#### 4.1.1 ⚙️ General & Quirks

- `wlrctl` segfaults on this system
- `wtype` cannot release physically-held modifiers (Super bleeds into keystrokes when used in `bind exec`)
- Use `hyprctl --batch` for multi-monitor changes to avoid misalignment warnings

#### 4.1.2 🖱️ Cursor

- **Theme**: `Bibata-Modern-Amber` (AUR: `bibata-cursor-git`), size 32
- **Config**: `hyprland.conf` — `env = XCURSOR_THEME/SIZE` + `env = HYPRCURSOR_THEME/SIZE`
- **Apply without re-login**: `hyprctl setcursor <ThemeName> <size>`
- **GTK**: `~/.config/gtk-3.0/settings.ini` — chezmoi-tracked

#### 4.1.3 🖱️ Mouse Emulation

- Mousemode submap (`SUPER+M`) is the reliable approach for keyboard-driven mouse scrolling via ydotool
- `wlrctl` segfaults; `wtype` can't release held Super — mousemode is the only working option

### 4.2 📊 Waybar

#### 4.2.1 🛡️ VPN Widget

- Script: `~/.config/waybar/vpn.sh` — checks `tun0` interface, JSON with class `connected`/`disconnected`
- Icons: `󰌾` (nf-md-lock) = on, `󱗒` (nf-md-shield_off_outline) = off
- Tooltip shows public IP via `curl ifconfig.me`
- CSS: connected = `#A6E3A1` (green), disconnected = `#F38BA8` (red)
- Position: between `custom/battery` and `hyprland/language`
- Connect: `sudo openvpn --config ~/.config/.secrets/openvpn.ovpn --daemon`
- Disconnect: `sudo pkill openvpn`
- `.ovpn` cert paths must be absolute — relative paths fail when running from other directories

### 4.3 🔍 Rofi

- **Keybinding conflicts**: Never add bare `Left`/`Right` to `kb-page-prev`/`kb-page-next` — they're already bound by rofi defaults and cause a fatal startup conflict that blocks rofi entirely. Use only `Control+h` / `Control+l` for page navigation.

### 4.4 📋 Clipse (Clipboard Manager)

- **Package**: `clipse-wayland-bin` (AUR) — replaces cliphist
- **Daemon**: `clipse -listen` — self-daemonizes by spawning two `wl-paste` workers (`--type image/png` and `--type text --wl-store`); `pgrep clipse` finds nothing after launch — that's normal
- **Hyprland exec-once**: `exec-once = clipse -listen`
- **Keybinding**: `Super+V` → `kitty --class clipse -e clipse`
- **Windowrule**: float by class `clipse`, centered, currently 2400×1500
- **Config**: `~/.config/clipse/config.json` (chezmoi-tracked)
- **Image display**: `type: kitty` (crisp, requires spacebar to preview), `scaleX/scaleY` ratio 2:1 to compensate terminal cell aspect, `heightCut` trims bottom rows to avoid artifacts
- **Navigation**: `ctrl+j/k` (up/down), `ctrl+h/l` (prevPage/nextPage)
- **clipse -listen behavior**: exits immediately after spawning workers — NOT a bug; workers are the `wl-paste` processes

### 4.5 🔔 Swaync

- `swaync.service` has `After=graphical-session.target` + `ConditionEnvironment=WAYLAND_DISPLAY` but still starts before `WAYLAND_DISPLAY` is in the systemd user environment → crash-loops 4–5× at boot, misses early notifications
- **Fix**: `exec-once = systemctl --user start swaync` in `hyprland.conf` — guarantees Wayland is ready

### 4.6 🖥️ switchreso

- Location: `~/scripts/switchreso/switchreso`, symlinked to `~/.local/bin/switchreso`
- Switches monitor resolutions via `hyprctl --batch` (atomic, no misalignment warnings)
- Presets: 4K (3840×2160@60), 2K (2560×1440@59.95), 1080p (1920×1080@60), Steamdeck (1280×800)
- DP-1 rates: 59.95 for 2K, 59.81 for Steamdeck; HDMI-A-1: 59.95 for 2K, 59.91 for Steamdeck
- Restarts waybar after every change (`pkill waybar; sleep 0.5; waybar &>/dev/null & disown`)
- Right monitor position derived from `${res%%x*}` (pixel width of new res, scale=1 always)

---

## 5. 🍎 macOS Desktop

### 5.1 ✈️ AeroSpace

- Config: `~/.config/aerospace/aerospace.toml`, helpers in `~/.config/aerospace/`
- Known limitation: floating window positioning unreliable on secondary monitors — [issue #1519](https://github.com/nikitabobko/AeroSpace/issues/1519)
- Ghostty new windows: use AppleScript Cmd+N approach, NOT direct binary launch (causes multiple dock icons)

### 5.2 📊 Sketchybar

- Installed via Homebrew HEAD (`felixkratz/formulae/sketchybar`)
- Config: `~/.config/sketchybar/` (Lua-based, `sketchybarrc` → `init.lua`)
- **SkyLight fix**: macOS 15.7.4 broke stable sketchybar 2.23.0. Fix: `brew uninstall sketchybar && brew install --HEAD sketchybar`. Also re-grant Screen Recording permission (TCC entries are path-specific).
- `display=0` (all displays) is broken — must use explicit `display=1,2`
- `brew outdated` crashes in sketchybar sandbox — use launchd job writing to `/tmp/sketchybar_brew_count`
- `updates = "when_shown"` means routine events don't fire when `drawing = false` — use `updates = "on"` for widgets that start hidden
- After brew version changes, always check TCC permissions — they're path-specific

---

## 6. 🛠️ Applications

### 6.1 📝 Neovim

- Config: `~/.config/nvim/`, keymaps: `~/.config/nvim/lua/config/keymaps.lua`
- `ft` is NOT a valid which-key field — use `cond = function() return vim.bo.filetype == "markdown" end`
- Nerd Font icon copy-paste through Claude terminal loses the character — write via Python: `python3 -c "icon = '\uf48a'; ..."`
- LazyExtras managed via `lazyvim.json` extras array — do NOT manually import extras in `lazy.lua` (causes "not managed by LazyExtras" warning). Keymap: `<leader>lx` → `:LazyExtras`
- LazyVim extras (`lang.yaml`, `lang.json`, etc.) bundle LSP + formatter + linter per language; Mason installs the actual binaries into `~/.local/share/nvim/mason/bin/`
- YAML formatter: use `yamlfmt` (Go, fast, YAML-aware) over `prettier` (Node.js, generalist) — set in `formatting.lua` as `opts.formatters_by_ft["yaml"] = { "yamlfmt" }`
- LazyVim `lang.yaml` extra does NOT wire up formatter by default — must explicitly add to `formatting.lua`
- Both `yamlfmt` and `prettier` refuse to format syntactically invalid YAML (indentation errors = parse errors in YAML) — LSP diagnostics are the real-time safety net
- CloudFormation `!Ref`, `!Sub`, `!If` etc. are YAML custom tags — not in any JSON schema, must be declared in `customTags` in yamlls settings or LSP will flag them as "Unresolved tag"
- SchemaStore.nvim: disable built-in schema store (`schemaStore.enable = false`) and use `require("schemastore").yaml.schemas()` — auto-detects schema per filename (CF, K8s, GH Actions, etc.)
- Full YAML setup lives in `formatting.lua`: yamlls server config (SchemaStore + customTags) + conform formatter (yamlfmt)

### 6.2 🗂️ Yazi

- Plugins in `~/.config/yazi/plugins/` (git repo), managed via `ya pkg` (subcommands: `add`, `install`, `upgrade`, `list`, `delete`)
- keymap.toml: use `[mgr] prepend_keymap = [...]` — mixed styles (`[[manager.prepend_keymap]]`) break bindings silently
- Shell commands use `$@` for hovered file (NOT `$1`)
- Extract: `{ on = "e", run = "shell 'ouch decompress \"$@\" --yes'", desc = "Extract archive" }`
- Compress: `{ on = "c", run = "plugin ouch", desc = "Compress file/folder" }` — ouch.yazi `entry()` prompts for name/format
- ouch.yazi: `entry()` = compress, `peek()` = archive preview — NOT an extractor
- `unrar` required for rar support
- **Active plugins**: `git`, `jump-to-char` (`f`), `mime-ext` (auto), `ouch` (`e`/`c`), `smart-enter` (`l`)
- **zoom.yazi is broken** — exits with code 127 (PATH issue in yazi sandbox), not worth debugging
- `init.lua` required for git plugin: `require("git"):setup()`
- chezmoi tracks plugins dir as a whole git repo — use `chezmoi re-add ~/.config/yazi/plugins` after any plugin changes

### 6.3 🎮 Ludusavi

- Game save backup tool; config at `~/.config/ludusavi/config.yaml` (chezmoi-tracked)
- Non-Steam Proton games need manual Custom Game entries with exact save paths + `STEAM_COMPAT_DATA_PATH` launch option per game; named prefix strategy documented in the README at the backup target
- Auto-backup via hourly cronie cron job; waybar icon `󰆓` (nf-md-floppy)

### 6.5 🎵 audioshell

- Lua script injected into mpv via `--script=` to observe `media-title` / `artist` properties
- Metadata written to `/tmp/audioshell_meta_$$`, read on each event loop iteration
- Pause/resume: `SIGSTOP`/`SIGCONT` on mpv PID (no IPC, no reconnect on resume)
- Animation: `$EPOCHREALTIME` at ~3fps (bash 5+), falls back to `$SECONDS` at 1fps (bash 3.2/macOS)
- macOS compat: integer-only `read -t` on bash 3.2, detected via `$BASH_VERSION`

---

## 7. 🐚 Shell & Scripting

### 7.1 ⚠️ Shell Script Anti-Patterns

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

### 7.2 📝 Scripts README Style

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

### 7.3 🗂️ Scripts Catalog (`~/scripts`)

Synced via git (repo: `Joslef/scripts`) — NOT chezmoi. All scripts symlinked to `~/.local/bin/`. Each script lives in its own subdirectory alongside a README.

| Script | Platform | Purpose |
|--------|----------|---------|
| `archmaint` | Linux | Arch maintenance: system update, orphan removal, cache cleanup, pacman DB check |
| `audioshell` | Linux/macOS | Terminal music player UI wrapper for mpv with metadata display (see § 6.5) |
| `brewsync` | macOS | Sync Homebrew + MAS package lists to GitHub; scheduled via launchd; supports restore |
| `changemachine` | Linux | Toggle Hyprland config between machine profiles (`lggram`/`gcube`) via tagged config lines |
| `chezclaudesync` | Linux | Snapshot `~/.claude` (settings, hooks, agents, memory) into chezmoi — secrets-safe |
| `createloginscreen` | Linux | One-shot SDDM setup: Catppuccin Mocha Pink theme, autologin, display config; run as root |
| `gitstatus` | Linux/macOS | Recursive git repo scanner: fetches remotes, flags dirty/behind/unpushed repos |
| `macfresh` | macOS | macOS maintenance: brew update, cask/MAS upgrades, system cleanup |
| `pkgsync` | Linux | Sync Arch package lists to GitHub; scheduled via systemd timer; supports restore |
| `switchreso` | Linux | Switch monitor resolution presets via `hyprctl --batch` (see § 4.6) |

---

## 8. 🔌 Claude Code

### 8.1 🧩 Plugin System

Plugin state lives in three places:
- `~/.claude/plugins/installed_plugins.json` — installed plugin registry
- `~/.claude/plugins/cache/<marketplace>/<plugin>/` — downloaded plugin files
- `~/.claude/plugins/data/<plugin>-<marketplace>/` — plugin runtime data

**swift-lsp auto-resurrection**: CC re-adds `swift-lsp@claude-plugins-official` on every startup because `~/.claude.json` contains a server-fetched feature flag list that includes it. This list is Anthropic-controlled and cannot be permanently removed. **Solution**: just leave it `disabled` in `/plugin` UI — it does nothing when disabled. Don't waste time trying to purge it.