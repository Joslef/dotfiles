#!/bin/bash
# Claude Code hook: track cumulative token usage per day.
# Fired on the Stop event; receives hook JSON on stdin.
#
# Daily totals file: /home/joerg/.claude/tokens/YYYY-MM-DD.txt
# Per-session last-seen file: /home/joerg/.claude/tokens/session-<id>.txt
#
# The Stop hook JSON looks like the statusline JSON; it contains
# context_window.total_input_tokens and context_window.total_output_tokens
# which are cumulative for the session.  We compute the delta since the
# last time this hook ran for the same session and add that to the day file.

set -euo pipefail

input=$(cat)

# Extract fields (fall back to 0 if absent)
session_id=$(echo "$input" | jq -r '.session_id // empty')
total_in=$(echo "$input"  | jq -r '.context_window.total_input_tokens  // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

# Sanity-check: if we have no session id or no token data, exit silently
if [ -z "$session_id" ] || [ "$total_in" = "0" ] && [ "$total_out" = "0" ]; then
    exit 0
fi

TOKEN_DIR="/home/joerg/.claude/tokens"
mkdir -p "$TOKEN_DIR"

TODAY=$(date +%Y-%m-%d)
DAY_FILE="${TOKEN_DIR}/${TODAY}.txt"
SESSION_FILE="${TOKEN_DIR}/session-${session_id}.txt"

# Read previously seen cumulative totals for this session
prev_in=0
prev_out=0
if [ -f "$SESSION_FILE" ]; then
    prev_in=$(awk  'NR==1{print $1}' "$SESSION_FILE" 2>/dev/null || echo 0)
    prev_out=$(awk 'NR==2{print $1}' "$SESSION_FILE" 2>/dev/null || echo 0)
fi

# Compute deltas (guard against going backwards, e.g. new session with same id)
delta_in=$(( total_in  > prev_in  ? total_in  - prev_in  : 0 ))
delta_out=$(( total_out > prev_out ? total_out - prev_out : 0 ))

# Nothing new to record
if [ "$delta_in" -eq 0 ] && [ "$delta_out" -eq 0 ]; then
    exit 0
fi

# Read existing day totals
day_in=0
day_out=0
if [ -f "$DAY_FILE" ]; then
    day_in=$(awk  'NR==1{print $1}' "$DAY_FILE" 2>/dev/null || echo 0)
    day_out=$(awk 'NR==2{print $1}' "$DAY_FILE" 2>/dev/null || echo 0)
fi

# Update day totals atomically (write to tmp then move)
new_day_in=$(( day_in + delta_in ))
new_day_out=$(( day_out + delta_out ))
tmp_day=$(mktemp "${DAY_FILE}.XXXXXX")
printf '%s\n%s\n' "$new_day_in" "$new_day_out" > "$tmp_day"
mv "$tmp_day" "$DAY_FILE"

# Update session baseline atomically
tmp_sess=$(mktemp "${SESSION_FILE}.XXXXXX")
printf '%s\n%s\n' "$total_in" "$total_out" > "$tmp_sess"
mv "$tmp_sess" "$SESSION_FILE"

exit 0
