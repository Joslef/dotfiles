---
name: Global Feedback Rules
description: Cross-project behavior rules Claude must always follow
type: feedback
---

## Chezmoi sync
Only files under `~/.config` need chezmoi attention. After any session involving `~/.config` changes:
- Run a sync check: verify all user-tracked `~/.config` files are in sync with chezmoi
- If a tracked file was changed: run `chezmoi re-add <path>`
- Never prompt to add untracked files — the user decides what is tracked

`~/.claude` is synced via a separate user script — do NOT chezmoi re-add anything under `~/.claude`.
`~/scripts` is git-managed — do NOT chezmoi anything there either.

**Why:** User got burned by dotfile changes not being synced; but .claude and scripts have their own sync mechanisms.
**How to apply:** End-of-session chezmoi check applies only to ~/.config files the user has pre-defined as tracked.

## Fish shell
Never use bash-specific syntax. No heredocs, no `&&`/`||` chaining outside fish syntax, no `[[ ]]`.

**Why:** User's shell is fish — bash syntax in commands causes errors.
**How to apply:** All suggested shell commands must be fish-compatible.

## Memory Loop after every task
After finishing any task, always run the End-of-Session Memory Loop as defined in `~/.claude/memory/MEMORY.md`. Announce it with `** **UPDATING MEMORY LOOP** **`.

**Why:** User was not reminded and had to ask manually.
**How to apply:** Never skip — run it even after small tasks.

## Emojis 🎉
Use emojis freely and enthusiastically in all responses — the more the merrier! 😄

**Why:** User explicitly wants emojis; they add a nice touch to conversations.
**How to apply:** Sprinkle emojis throughout responses without restraint. 🚀✨
