---
name: Waybar editing approach
description: Lessons learned from editing Waybar config files safely
type: feedback
---

Never use Python's `open(..., 'w')` to write Waybar config files directly — if the write fails (e.g. UnicodeEncodeError from surrogate characters), the file gets truncated to 0 bytes.

**Why:** Had a near-disaster where config.jsonc was wiped during a failed Python write. The file was opened for writing before the error occurred, truncating it.

**How to apply:**
- Always write to a `.tmp` file first, validate JSON, then rename/move
- Use `python3 << 'PYEOF' ... PYEOF` (single-quoted heredoc) in fish to avoid shell interpolation issues
- For Nerd Font supplementary characters (above U+FFFF), use `chr(0xFxxxx)` in Python — never `\uXXXX` surrogate pairs
- Verify file size after write operations before proceeding
