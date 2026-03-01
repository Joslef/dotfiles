# audioshell project memory

## $EPOCHREALTIME locale bug (fixed)
`$EPOCHREALTIME` uses the system locale decimal separator — commas on DE/EU locales.
Fix: normalize before arithmetic with `${EPOCHREALTIME/,/.}` (line 203 of audioshell).

## README style (~/scripts)
- Title: `# <emoji> <name>`
- One-sentence tagline below title
- All `##` headings carry an emoji
- Installation section uses `cp` + `chmod +x` pattern
- README written for audioshell at `/home/joerg/scripts/audioshell/README.md`

## audioshell architecture notes
- Lua script injected into mpv via `--script=` to observe `media-title` / `artist` properties
- Metadata written to `/tmp/audioshell_meta_$$`, read on each event loop iteration
- Pause/resume: `SIGSTOP`/`SIGCONT` on mpv PID (no IPC, no reconnect on resume)
- Animation: `$EPOCHREALTIME` at ~3fps (bash 5+), falls back to `$SECONDS` at 1fps (bash 3.2/macOS)
- macOS compat: integer-only `read -t` on bash 3.2, detected via `$BASH_VERSION`
