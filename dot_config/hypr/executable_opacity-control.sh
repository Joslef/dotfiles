#!/bin/bash
# Control global window opacity for all Hyprland windows
# Usage: opacity-control.sh [up|down|reset]

ACTION="${1:-reset}"
STEP=0.05
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/hypr-opacity-global"

# Default and reset values
DEFAULT_ACTIVE=1.0
DEFAULT_INACTIVE=0.75

case "$ACTION" in
    reset)
        rm -f "$STATE_FILE"
        hyprctl keyword decoration:active_opacity "$DEFAULT_ACTIVE"
        hyprctl keyword decoration:inactive_opacity "$DEFAULT_INACTIVE"
        exit 0
        ;;
    up|down)
        ;;
    *)
        exit 1
        ;;
esac

# Read current adjusted opacity (single value for both active/inactive)
if [ -f "$STATE_FILE" ]; then
    CURRENT=$(cat "$STATE_FILE")
    if ! [[ "$CURRENT" =~ ^[0-9]+(\.[0-9]+)?$ ]] || \
       ! LC_NUMERIC=C awk "BEGIN { exit !($CURRENT >= 0.1 && $CURRENT <= 1.0) }"; then
        CURRENT=1.0
    fi
else
    CURRENT=1.0
fi

if [ "$ACTION" = "up" ]; then
    NEW=$(LC_NUMERIC=C awk "BEGIN {v = $CURRENT + $STEP; if (v > 1.0) v = 1.0; printf \"%.2f\", v}")
else
    NEW=$(LC_NUMERIC=C awk "BEGIN {v = $CURRENT - $STEP; if (v < 0.1) v = 0.1; printf \"%.2f\", v}")
fi

echo "$NEW" > "$STATE_FILE"
hyprctl keyword decoration:active_opacity "$NEW"
hyprctl keyword decoration:inactive_opacity "$NEW"
