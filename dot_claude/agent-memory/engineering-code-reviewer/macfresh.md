# macfresh Review Notes (2026-03-08)

File: `/Users/joerg/scripts/macfresh/macfresh`
Single-file bash script, ~386 lines, `set -euo pipefail`.
macOS equivalent of archmaint.

## Confirmed Bugs

### CRITICAL: confirm() aborts script under set -e when user answers No (line 57-67)
`confirm()` returns `false` (exits 1) for "no" answers.
Under `set -e`, any function returning non-zero causes script abort.
When used as `if confirm ...; then`, Bash protects that specific call site, BUT
if `confirm` is ever called outside an if-context it will abort. More dangerously,
within the if branch the `false` return propagates correctly — this is fine by itself.
HOWEVER: the `read -r -p` inside confirm() (line 58) has NO `|| true` guard.
If the user hits Ctrl+D (EOF), read returns non-zero, aborting the script via set -e.
All other read calls in the file correctly use `|| true`; this one is missing it.
Fix: `read -r -p "$1 [Y/n]: " response || true`

### HIGH: Unquoted glob in rm -rf can silently delete wrong paths (lines 236, 244, 252)
`rm -rf ~/Library/Caches/*`
If ~/Library/Caches is empty, the glob `*` expands to the literal string `*` (bash default),
causing `rm -rf` to look for a file literally named `*` — benign but confusing.
More dangerously: if IFS or globbing has been modified, or if a directory entry contains
spaces/special chars, the unquoted expansion can split unexpectedly.
Canonical fix: `rm -rf "${HOME}/Library/Caches/"*`  (quote the path, leave glob unquoted)
or: `find "${HOME}/Library/Caches" -mindepth 1 -delete`

### HIGH: mas outdated exits non-zero when no updates are available (line 112)
`mas outdated` exits with code 1 when there are no pending updates.
Under `set -euo pipefail` this aborts the script before the confirm prompt.
Fix: `mas outdated || true`

### MEDIUM: brew list --formula | wc -l aborts under pipefail if brew fails (lines 277-278)
`$(brew list --formula | wc -l | tr -d ' ')`
If brew exits non-zero (network issue, lock, etc.), pipefail propagates into the
command substitution and aborts the script mid-info display.
Same applies to `brew list --cask` on line 278.
Fix: `$(brew list --formula 2>/dev/null | wc -l | tr -d ' ')` or capture with `|| echo 0`

### MEDIUM: mas list | wc -l aborts under pipefail if mas fails (line 282)
Same pattern as above. mas can fail if not signed in to App Store.
Fix: `$(mas list 2>/dev/null | wc -l | tr -d ' ')` with fallback.

### LOW: do_doctor skips press-Enter when user declines (lines 201-212)
If user answers No to "Run brew doctor?", the function returns without any press-Enter pause.
All other decline paths in the script have a pause. Menu flashes back immediately.

### LOW: brew update called twice in separate menu paths without deduplication
do_formulae and do_casks each call `brew update` independently.
If user runs option "a" (Run All), brew update runs twice (do_formulae then do_casks).
Not a bug, just inefficient.

## Security Notes
- rm -rf targets are confined to ~/Library/* (user-owned), no sudo required. Acceptable risk.
- No secrets or credentials in the script.
- No eval or dynamic code execution.
