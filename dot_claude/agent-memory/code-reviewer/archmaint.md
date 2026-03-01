# archmaint Review Notes (2026-03-01)

File: `/home/joerg/scripts/archmaint/archmaint`
Single-file bash script, ~310 lines, `set -euo pipefail`.

## Confirmed Bugs

### HIGH: --noconfirm after -- in do_quick xargs (line 231)
`echo "$orphans" | xargs -r sudo pacman -Rns -- --noconfirm`
xargs appends package names after `--noconfirm`, so final command is:
`sudo pacman -Rns -- --noconfirm pkg1 pkg2`
`--` ends option parsing; `--noconfirm` becomes a literal package name to remove.
pacman will error: "target not found: --noconfirm"
Fix: move --noconfirm before --: `sudo pacman -Rns --noconfirm -- pkg1 pkg2`

### HIGH: grep false-positive on pacman -Dk success output (line 238)
`if pacman -Dk 2>&1 | grep -qi "error"; then print_warning "Database issues detected"`
pacman -Dk success output: "No database errors have been found!"
"errors" matches grep -qi "error" → always fires even when DB is clean.
Fix: grep for "^error:" prefix or use pacman -Dk exit code directly.

### MEDIUM: ls glob in $() aborts script under set -euo pipefail when cache empty (lines 120, 218)
`$(ls /var/cache/pacman/pkg/*.pkg.tar* 2>/dev/null | wc -l)`
When no files match, ls exits 2; pipefail propagates this out of $() → script aborts.
Line 218 has `|| cache_count=0` fallback but it doesn't help because the abort happens inside the substitution.
Fix: use `find /var/cache/pacman/pkg -maxdepth 1 -name '*.pkg.tar*' 2>/dev/null | wc -l`

### MEDIUM: paccache -r without sudo in do_quick silently fails (line 235)
`paccache -r 2>/dev/null || true`
/var/cache/pacman/pkg/ is root-owned; non-root paccache -r fails silently.
Cache cleanup step in --quick mode is effectively a no-op.
Fix: `sudo paccache -r 2>/dev/null || true`

### MEDIUM: do_info blocking prompt breaks --quick non-interactive mode (line 221)
do_quick calls do_info, which ends with `read -r -p "Press Enter to continue..."`.
This blocks `archmaint --quick` intended for scripted/automated use.
Additionally, menu option 7 calls do_quick then adds another read prompt — double-prompt.
Fix: pass a flag to do_info to suppress the prompt when called from do_quick.

### LOW: read with EOF (Ctrl+D) aborts script under set -e
`read -r -p "..."` returns non-zero on EOF; set -e aborts the script.
Affects the main menu loop and all "Press Enter" prompts.
Fix: append `|| true` to all interactive read calls.

### LOW: UX inconsistency - missing press-Enter after confirm decline in do_cache (lines 143-161)
Options 2 and 3: if user declines confirm, function returns immediately with no pause.
The menu flashes back. All other paths have a press-Enter.
