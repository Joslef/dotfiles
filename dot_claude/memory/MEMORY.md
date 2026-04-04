# 🧠 Global Memory

## 🔄 Memory Update Loop

After finishing any task, always run the End-of-Session Memory Loop. Announce it with `** **UPDATING MEMORY LOOP** **`.

⚠️ **MEMORY RULE CONFIRMED** ⚠️
The one and only valid save location for memory is `~/.claude/memory/MEMORY.md`. This is absolute and non-negotiable. Never write to `.claude/projects/` or any other location — not as separate files, not as subdirectories, not ever. If it isn't going into `~/.claude/memory/MEMORY.md` directly, it isn't being saved.

After reading and understanding this rule, confirm with: `** **MEMORY RULE CONFIRMED** **`

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
- **Learning**: Preparing for **AWS Cloud Practitioner** exam (as of 2026-03); actively studying AWS services, architecture, and concepts
- **Interests**: Deeply curious about AWS — enjoys understanding how services interconnect, where the gaps are, and the "why" behind AWS design decisions

---

## 🖥️ Environment

### Linux

- **Shell**: fish — never use bash-specific syntax (no heredocs, no `&&`/`||` chaining outside fish syntax, no `[[ ]]`)
- **OS**: CachyOS (Arch-based), AUR helper: paru
- **Desktop**: Hyprland + SDDM
- **Font**: JetBrainsMono Nerd Font (confirmed in rofi)
- **Mouse**: Logitech MX Master 3 — solaar/wlrctl removed, no DPI tooling; use Hyprland mousemode submap (`SUPER+M`) for keyboard-driven scrolling via ydotool
- **Hyprland notes**: `wlrctl` segfaults on this system; `wtype` cannot release physically-held modifiers (Super bleeds into keystrokes when used in `bind exec`); mousemode submap is the reliable approach for mouse emulation
- **Monitors**: DP-1 = Display Left (right physically, ID 0), HDMI-A-1 = Display Right (LG Ultra HD, ID 1) at x=3840. Both scale=1.0. Use `hyprctl --batch` for multi-monitor changes to avoid Hyprland misalignment warnings
- **Streaming**: Sunshine (LizardByte) running as systemd user service; capture=wlr (Hyprland), encoder=h264_vaapi (AMD RX 6650 XT); requires `LIBVA_DRIVER_NAME=radeonsi` in service env; config at `~/.config/sunshine/`; UFW ports 47984/47989/47990/48010 tcp + 47998/47999/48000/48002/5353 udp open

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

### 🗃️ Shorthand: "chezmoi"

When Joerg writes just **"chezmoi"**, that means: re-add all files changed during the session and add any new `~/.config` files introduced this session. Then verify nothing was missed — cross-check all session-touched files against `chezmoi list` and run `chezmoi re-add` or `chezmoi add` on any that aren't yet tracked. Do it, don't suggest it.

### 🔁 Shorthand: "loop"

When Joerg writes just **"loop"**, that means: run the full End-of-Session Memory Loop — reflect on everything learned this session, write new insights to `~/.claude/memory/MEMORY.md` (the global file), and review existing entries for staleness or duplication. **Never write to project-specific memory files.**

### 📋 Commands to Copy-Paste

When showing commands the user needs to run themselves, **never prefix them with `!`**. Joerg copies commands directly and the `!` breaks them.

### 🧠 Memory Load Confirmation

At the start of every session, include `** **GLOBAL MEMORY LOADED** **` in the first response to confirm the memory injection was successful. Skip this on `q:` sessions.

The statusbar shows a 🧠 icon when the `SessionStart` hook has run and memory was injected for the current session. Flag: `/tmp/claude/memory-loaded-<session_id>` — created by the hook using session_id from its stdin payload, checked in the statusbar via `.session_id` from its input JSON. Cleared on reboot (lives in `/tmp`).

**Statusbar input JSON fields** (confirmed via logging): `session_id`, `transcript_path`, `cwd`, `model` (`id`, `display_name`), `workspace` (`current_dir`, `project_dir`, `added_dirs`), `version`, `output_style`, `cost`, `context_window` (`total_input_tokens`, `total_output_tokens`, `context_window_size`, `current_usage`, `used_percentage`, `remaining_percentage`), `exceeds_200k_tokens`, `rate_limits` (`five_hour`/`seven_day` with `used_percentage` + `resets_at` as epoch), `vim` (`mode`).

**`~/.claude/CLAUDE.md`** exists — enforces memory load confirmation at session start via project instructions (more reliable than memory alone since it's part of the system prompt).

**Hook stdin payload** contains session context including `session_id` — hooks can read it via `$(cat)` before doing other work.

### ⚡ Quick Questions

If the session starts with `q:` — no memory writes, no end-of-session loop.

### 🔍 Unknown Topics → Research First

If Joerg mentions a tool, service, or concept that is unfamiliar or unclear, don't guess or ask — run a web search first, get the facts, then answer. Never respond with "I'm not sure what that is" without first attempting a search.

### 🤖 Self-Sufficiency on the Machine

Figure things out independently — read files, search the codebase, run commands, check configs, browse the web. Never ask Joerg to look something up or gather info that can be obtained directly. The only thing Joerg should ever need to do is run `sudo` commands when elevated privileges are required.

### 🐟 Fish Shell

Never use bash-specific syntax. No heredocs, no `&&`/`||` chaining outside fish syntax, no `[[ ]]`.

### 📁 Chezmoi Sync

Only files under `~/.config` need chezmoi attention. After any session involving `~/.config` changes:

- Run a sync check: verify all user-tracked `~/.config` files are in sync with chezmoi
- If a tracked file was changed: **actually run** `chezmoi re-add <path>` — do not just suggest it to the user
- If a new `~/.config` file was created during the session that affects the look or behavior of the machine (cursor, theme, keybindings, bar config, etc.) — add it to chezmoi with `chezmoi add <path>`. Don't ask, just do it.
- Never add files that are clearly auto-generated, caches, or runtime state

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
- LazyExtras managed via `lazyvim.json` extras array — do NOT manually import extras in `lazy.lua` (causes "not managed by LazyExtras" warning). Keymap: `<leader>lx` → `:LazyExtras`
- LazyVim extras (`lang.yaml`, `lang.json`, etc.) bundle LSP + formatter + linter per language; Mason installs the actual binaries into `~/.local/share/nvim/mason/bin/`
- YAML formatter: use `yamlfmt` (Go, fast, YAML-aware) over `prettier` (Node.js, generalist) — set in `formatting.lua` as `opts.formatters_by_ft["yaml"] = { "yamlfmt" }`
- LazyVim `lang.yaml` extra does NOT wire up formatter by default — must explicitly add to `formatting.lua`
- Both `yamlfmt` and `prettier` refuse to format syntactically invalid YAML (indentation errors = parse errors in YAML) — LSP diagnostics are the real-time safety net
- CloudFormation `!Ref`, `!Sub`, `!If` etc. are YAML custom tags — not in any JSON schema, must be declared in `customTags` in yamlls settings or LSP will flag them as "Unresolved tag"
- SchemaStore.nvim: disable built-in schema store (`schemaStore.enable = false`) and use `require("schemastore").yaml.schemas()` — auto-detects schema per filename (CF, K8s, GH Actions, etc.)
- Full YAML setup lives in `formatting.lua`: yamlls server config (SchemaStore + customTags) + conform formatter (yamlfmt)

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

## 🖥️ switchreso Script

- Location: `~/scripts/switchreso/switchreso`, symlinked to `~/.local/bin/switchreso`
- Switches monitor resolutions via `hyprctl --batch` (atomic, no misalignment warnings)
- Presets: 4K (3840×2160@60), 2K (2560×1440@59.95), 1080p (1920×1080@60), Steamdeck (1280×800)
- DP-1 rates: 59.95 for 2K, 59.81 for Steamdeck; HDMI-A-1: 59.95 for 2K, 59.91 for Steamdeck
- Restarts waybar after every change (`pkill waybar; sleep 0.5; waybar &>/dev/null & disown`)
- Right monitor position derived from `${res%%x*}` (pixel width of new res, scale=1 always)

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

## 📋 Clipse Clipboard Manager

- **Package**: `clipse-wayland-bin` (AUR) — replaces cliphist
- **Daemon**: `clipse -listen` — self-daemonizes by spawning two `wl-paste` workers (`--type image/png` and `--type text --wl-store`); `pgrep clipse` finds nothing after launch — that's normal
- **Hyprland exec-once**: `exec-once = clipse -listen`
- **Keybinding**: `Super+V` → `kitty --class clipse -e clipse`
- **Windowrule**: float by class `clipse`, centered, currently 2400×1500
- **Config**: `~/.config/clipse/config.json` (chezmoi-tracked)
- **Image display**: `type: kitty` (crisp, requires spacebar to preview), `scaleX/scaleY` ratio 2:1 to compensate terminal cell aspect, `heightCut` trims bottom rows to avoid artifacts
- **Navigation**: `ctrl+j/k` (up/down), `ctrl+h/l` (prevPage/nextPage)
- **clipse -listen behavior**: exits immediately after spawning workers — NOT a bug; workers are the `wl-paste` processes

---

## 🖥️ Rofi Config

- **Keybinding conflicts**: Never add bare `Left`/`Right` to `kb-page-prev`/`kb-page-next` — they're already bound by rofi defaults and cause a fatal startup conflict that blocks rofi entirely. Use only `Control+h` / `Control+l` for page navigation.

---

## 🔌 Claude Code Plugin System

Plugin state lives in three places:
- `~/.claude/plugins/installed_plugins.json` — installed plugin registry
- `~/.claude/plugins/cache/<marketplace>/<plugin>/` — downloaded plugin files
- `~/.claude/plugins/data/<plugin>-<marketplace>/` — plugin runtime data

**swift-lsp auto-resurrection**: CC re-adds `swift-lsp@claude-plugins-official` on every startup because `~/.claude.json` contains a server-fetched feature flag list that includes it. This list is Anthropic-controlled and cannot be permanently removed. **Solution**: just leave it `disabled` in `/plugin` UI — it does nothing when disabled. Don't waste time trying to purge it.

---

## 🗂️ Yazi Config

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

---

## 🖱️ Hyprland Cursor

- **Theme**: `Bibata-Modern-Amber` (AUR: `bibata-cursor-git`), size 32
- **Config**: `hyprland.conf` — `env = XCURSOR_THEME/SIZE` + `env = HYPRCURSOR_THEME/SIZE`
- **Apply without re-login**: `hyprctl setcursor <ThemeName> <size>`
- **GTK**: `~/.config/gtk-3.0/settings.ini` — chezmoi-tracked

---

## 🛡️ Waybar VPN Widget

- Script: `~/.config/waybar/vpn.sh` — checks `tun0` interface, JSON with class `connected`/`disconnected`
- Icons: `󰌾` (nf-md-lock) = on, `󱗒` (nf-md-shield_off_outline) = off
- Tooltip shows public IP via `curl ifconfig.me`
- CSS: connected = `#A6E3A1` (green), disconnected = `#F38BA8` (red)
- Position: between `custom/battery` and `hyprland/language`
- Connect: `sudo openvpn --config ~/.config/.secrets/openvpn.ovpn --daemon`
- Disconnect: `sudo pkill openvpn`
- `.ovpn` cert paths must be absolute — relative paths fail when running from other directories

---

## 🎧 Bluetooth Audio (WH-1000XM4)

- **MAC**: `80:99:E7:2E:99:D4` — old/stale device MAC sometimes in state files: `E8:EE:CC:C5:8F:7E` (remove if found)
- **Volume control**: `~/.config/wireplumber/wireplumber.conf.d/51-bluez-config.conf` must have `bluez5.enable-absolute-volume = true` — `false` breaks system volume slider
- **Auto-switch default sink**: WirePlumber persists default sink in `~/.local/state/wireplumber/default-nodes`; `find-selected-default-node.lua` gives saved node a +30000 priority bonus — stale MAC means headset never wins. Fix: correct the file, then `wpctl set-default <id>` to persist
- **Profile race condition** (upstream bug): log `s-device: Could not find valid non-headset profile, not switching` — fires when A2DP not yet enumerated at connect time; cosmetic once state is correct
- **After wireplumber restart**: headset may reconnect in HFP — fix with `bluetoothctl disconnect` + `bluetoothctl connect` to renegotiate A2DP

---

## ☁️ AWS Cloud Practitioner Study Notes

### Service Distinctions (common exam traps)

- **CodeDeploy vs CodePipeline**: CodeDeploy *executes* deployments (also works on-premises via agent); CodePipeline *orchestrates* the CI/CD workflow but doesn't deploy anything itself. "On-premises deployment" → CodeDeploy.
- **CloudFront vs S3 Transfer Acceleration**: CloudFront = CDN, serves content *out* to global users fast. S3TA = speeds up *uploads into* S3. "Global static website performance" → CloudFront.
- **Kendra vs Comprehend**: Kendra = enterprise search (find relevant documents). Comprehend = NLP text analysis (sentiment, entities, PII). Both are AI services (pre-built, no ML knowledge needed).
- **Read Replica vs Multi-AZ**: Read Replica = scalability (offload read traffic, async replication, no auto-failover). Multi-AZ = availability (sync replication, auto-failover). "High availability/failover" → Multi-AZ. "Read-heavy/scalability" → Read Replica.
- **VPC Endpoint vs others for private S3 access**: VPC Endpoint keeps VPC→S3 traffic inside AWS network (no internet). Direct Connect = on-premises→AWS private line. Transit Gateway = connects VPCs at scale. "Privately connect VPC to S3" → VPC Endpoint (Gateway type, free).
- **VPC Peering vs Transit Gateway**: Peering = direct 1:1, non-transitive, gets messy at scale. TGW = hub-and-spoke, transitive, handles VPNs/Direct Connect too. "Hundreds of VPCs / centralized" → TGW.

### Global vs Regional Services (memorize these)

Global: **IAM, CloudFront, Route 53, WAF** (when with CloudFront), **AWS Organizations**
Everything else is almost always regional.

### Shared Responsibility Model

- **Shared controls** (both AWS and customer): Patch Management, Configuration Management, Awareness & Training
- "Configuration Management is customer-only" is WRONG — it's shared
- **Shield Standard** = AWS's responsibility (automatic, free, no customer action). Shield Advanced = customer's (paid, opted-in).
- **Separate invoices** = separate AWS accounts (full stop — tags/Organizations/Cost Explorer cannot produce separate invoices)

### Networking

- **Site-to-Site VPN** = on-premises ↔ AWS only. Two components: Customer Gateway (CGW, your side) + Virtual Private Gateway (VGW, AWS side).
- Region↔Region and AZ↔AZ traffic within AWS uses AWS's private backbone — no VPN needed.

### Billing & CloudWatch

- **CloudWatch billing metrics** always stored in `us-east-1` — hardcoded, regardless of where resources or account are. Must switch to us-east-1 to create billing alarms.
- Billing metrics = dollar amounts (EstimatedCharges per service/region), updated a few times/day.

### Storage

- **EFS** = shared NFS file system, multi-AZ by default, accessible across VPCs (via peering) and regions (via inter-region peering). Many EC2s mount simultaneously.
- **EBS** = block storage, single AZ, one EC2 at a time (mostly). "Shared access across instances" → EFS. "Single instance disk" → EBS.
- **VPC Endpoint types**: Gateway (S3 + DynamoDB only, free) vs Interface (most other services, costs money).

### AWS ML Service Tiers

1. **AI Services** — pre-built APIs, no ML knowledge (Comprehend, Kendra, Rekognition, Transcribe, Translate, Polly)
2. **ML Services** — build/train your own models (SageMaker)
3. **ML Frameworks/Infrastructure** — low-level compute (EC2 with GPUs)

### NotebookLM Exam Prep Prompt

Joerg uses wrong-answer screenshots + this prompt in Google NotebookLM to generate targeted practice tests:

> These screenshots are my wrong answers from AWS Cloud Practitioner practice tests. Based on them, generate a new practice test that specifically targets my weak areas.
>
> **My mistake patterns:** confusing similar-purpose services, scalability vs availability, global vs regional scope, Shared Responsibility Model edge cases, specific AWS facts, networking distinctions.
>
> **Format:** 20–30 questions, 4 options. Multi-select questions: use multi-select format if supported, otherwise split into two separate single-answer questions. Plausible wrong answers (same type of trap). Answer key with explanation of why correct answer is right AND why the most tempting wrong answer is wrong. CCP exam difficulty. Each generation must select a **random subset** of topics — source contains ~100 questions, each test draws a fresh random 20–30 so repeated runs produce different quizzes.

---

## 🔔 Swaync Startup Race

- `swaync.service` has `After=graphical-session.target` + `ConditionEnvironment=WAYLAND_DISPLAY` but still starts before `WAYLAND_DISPLAY` is in the systemd user environment → crash-loops 4–5× at boot, misses early notifications
- **Fix**: `exec-once = systemctl --user start swaync` in `hyprland.conf` — guarantees Wayland is ready
