---
name: chezmoi does not manage ~/scripts
description: ~/scripts is NOT tracked by chezmoi — never add files from there to chezmoi
type: feedback
---

Do not add files from `~/scripts` to chezmoi. This directory is intentionally outside chezmoi's management.

**Why:** User explicitly corrected this when a script was added by mistake.

**How to apply:** When the user asks to "add changes to chezmoi", only add files under `~/.config` or other dotfile locations — never anything under `~/scripts`.
