#!/bin/bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
session_id=$(echo "$input" | jq -r '.session_id // empty')

TOKEN_DIR="/home/joerg/.claude/tokens"

# Accumulate token usage into daily files (statusline has the data; Stop hook does not)
if [ -n "$session_id" ] && [ "$total_in" != "0" ]; then
    mkdir -p "$TOKEN_DIR"
    TODAY=$(date +%Y-%m-%d)
    DAY_FILE="${TOKEN_DIR}/${TODAY}.txt"
    SESSION_FILE="${TOKEN_DIR}/session-${session_id}.txt"

    prev_in=0
    prev_out=0
    if [ -f "$SESSION_FILE" ]; then
        prev_in=$(awk 'NR==1{print $1}' "$SESSION_FILE" 2>/dev/null || echo 0)
        prev_out=$(awk 'NR==2{print $1}' "$SESSION_FILE" 2>/dev/null || echo 0)
    fi

    delta_in=$(( total_in > prev_in ? total_in - prev_in : 0 ))
    delta_out=$(( total_out > prev_out ? total_out - prev_out : 0 ))

    if [ "$delta_in" -gt 0 ] || [ "$delta_out" -gt 0 ]; then
        day_in=0; day_out=0
        if [ -f "$DAY_FILE" ]; then
            day_in=$(awk 'NR==1{print $1}' "$DAY_FILE" 2>/dev/null || echo 0)
            day_out=$(awk 'NR==2{print $1}' "$DAY_FILE" 2>/dev/null || echo 0)
        fi
        printf '%s\n%s\n' "$(( day_in + delta_in ))" "$(( day_out + delta_out ))" > "$DAY_FILE"
        printf '%s\n%s\n' "$total_in" "$total_out" > "$SESSION_FILE"
    fi
fi

# Full current working directory path, replacing $HOME with ~.
if [ -n "$cwd" ]; then
    dir="$cwd"
else
    dir="$(pwd)"
fi
if [[ "$dir" == "$HOME"* ]]; then
    dir="~${dir#$HOME}"
fi

# Git branch (skip optional locks to avoid interfering with running git operations)
git_info=""
if git --no-optional-locks rev-parse --git-dir &>/dev/null 2>&1; then
    branch=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
             || git --no-optional-locks rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        git_info=" ($branch)"
    fi
fi

CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RESET='\033[0m'

printf "${CYAN}%s${RESET}${YELLOW}%s${RESET}" "$dir" "$git_info"

if [ -n "$model" ]; then
    printf "  %s" "$model"
fi

# Show remaining context % (falling back to used % if remaining not available)
if [ -n "$remaining" ]; then
    remaining_int=${remaining%.*}
    printf "  ctx:%s%% left" "$remaining_int"
elif [ -n "$used" ]; then
    used_int=${used%.*}
    printf "  ctx:%s%% used" "$used_int"
fi

fmt_k() {
    local n=$1
    if [ "$n" -ge 1000000 ]; then
        printf '%dM' $(( n / 1000000 ))
    elif [ "$n" -ge 1000 ]; then
        printf '%dk' $(( n / 1000 ))
    else
        printf '%d' "$n"
    fi
}

# Daily token totals
TODAY=$(date +%Y-%m-%d)
DAY_FILE="${TOKEN_DIR}/${TODAY}.txt"
if [ -f "$DAY_FILE" ]; then
    day_in=$(awk  'NR==1{print $1}' "$DAY_FILE" 2>/dev/null || echo 0)
    day_out=$(awk 'NR==2{print $1}' "$DAY_FILE" 2>/dev/null || echo 0)
    if [ "$day_in" -gt 0 ] || [ "$day_out" -gt 0 ]; then
        printf "  day:%s/%s" "$(fmt_k "$day_in")" "$(fmt_k "$day_out")"
    fi
fi

# Weekly token totals (Monday through today, ISO week)
week_in=0
week_out=0
dow=$(date +%u)  # 1=Mon … 7=Sun
for i in $(seq 0 $(( dow - 1 ))); do
    d=$(date -d "$i days ago" +%Y-%m-%d 2>/dev/null)
    f="${TOKEN_DIR}/${d}.txt"
    if [ -f "$f" ]; then
        d_in=$(awk  'NR==1{print $1}' "$f" 2>/dev/null || echo 0)
        d_out=$(awk 'NR==2{print $1}' "$f" 2>/dev/null || echo 0)
        week_in=$(( week_in + d_in ))
        week_out=$(( week_out + d_out ))
    fi
done
if [ "$week_in" -gt 0 ] || [ "$week_out" -gt 0 ]; then
    printf "  wk:%s/%s" "$(fmt_k "$week_in")" "$(fmt_k "$week_out")"
fi
