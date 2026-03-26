# Global Memory

## User
- [User profile](user_profile.md) — environment (Linux/macOS), shell, dotfile tooling, preferences

## Feedback (applies in every project)
- [Global behavior rules](feedback_global.md) — chezmoi sync, fish shell, scripts git workflow

## Agent Knowledge
- [Bash anti-patterns](agent_bash_patterns.md) — shell script bugs found in user's scripts
- [Scripts README style](agent_docs_style.md) — documentation style for ~/scripts tools

## End-of-Session Protocol
After finishing any task, always run the MEMORY loop (announce this to the user with the message "** **UPDATING MEMORY LOOP** **"):

1. **Session learnings** — write new insights, corrections, or findings into the appropriate linked file (never write content directly into MEMORY.md). If no suitable file exists, create a new one and add a single index link to MEMORY.md following the existing style.
2. **Memory review** — inspect MEMORY.md and all linked files: shorten verbose entries, remove irrelevant content, deduplicate. Be conservative — memory should grow first, only trim what is clearly redundant or no longer applicable.
