# Memory

## AeroSpace Window Manager
- Config at `~/.config/aerospace/aerospace.toml`
- Helper scripts in `~/.config/aerospace/`
- Known limitation: floating window positioning is unreliable on secondary (non-main) monitors — [issue #1519](https://github.com/nikitabobko/AeroSpace/issues/1519)
- Sticky floating windows ([issue #2](https://github.com/nikitabobko/AeroSpace/issues/2)) is locked to collaborators — cannot react or comment
- Monitors: LG Ultra HD (secondary), LG HDR 4K (main), Sidecar (iPad)
- Ghostty new windows: use AppleScript Cmd+N approach, NOT direct binary launch (causes multiple dock icons)

## Workflow
- [Chezmoi sync rule](feedback_chezmoi_sync.md) — always sync dotfile changes with chezmoi; ask before adding new files
- [Agent usage transparency](feedback_agent_usage.md) — when skipping a requested agent, inform upfront
