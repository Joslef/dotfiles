---
name: chezmoi-sync
description: Always sync changes to .config, .claude, and other dotfiles with chezmoi; ask before adding new untracked files
type: feedback
---

When making changes to `~/.config`, `~/.claude`, or other dotfile-relevant paths, always sync the changes with chezmoi.

- If the file is already tracked by chezmoi: run `chezmoi re-add <path>` after editing.
- If the file is **not yet tracked** by chezmoi: ask the user whether it should be added before running `chezmoi add`.
