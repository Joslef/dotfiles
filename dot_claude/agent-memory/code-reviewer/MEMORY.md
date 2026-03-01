# Code Reviewer Agent Memory

## archmaint (Arch Linux maintenance script)
- Reviewed 2026-03-01. See `archmaint.md` for full findings.
- Key recurring patterns: `ls glob | wc -l` in command substitution fails under `set -euo pipefail` when cache is empty; `--noconfirm` placed after `--` in xargs command is treated as a package name.

## General Bash Patterns to Watch
- `ls /path/*.glob 2>/dev/null | wc -l` in a `$()` substitution under `set -euo pipefail`: ls exits non-zero on no matches AND pipefail propagates that exit code out of the substitution, causing script abort. Use `find` or `shopt -s nullglob` instead.
- `xargs cmd -- --flag`: `--` ends option parsing, so `--flag` after it is treated as an argument (e.g. a package name), not an option. Always put flags BEFORE `--`.
- `grep -qi "error"` on `pacman -Dk` output: the success message "No database errors have been found!" contains the word "errors" — always false-positive matches.
- `read` under `set -e`: EOF (Ctrl+D) causes `read` to return non-zero, aborting the script. Guard with `read ... || true` in interactive loops.
- `paccache -r` (without sudo) silently fails because `/var/cache/pacman/pkg/` is root-owned. Always prefix with `sudo`.
