#!/bin/bash
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

DPIS=(1000 1250 1500 1750 2000 2250 2500)
STATE_FILE="/tmp/mx-dpi-index"

if [[ -f "$STATE_FILE" ]]; then
    INDEX=$(cat "$STATE_FILE")
else
    INDEX=4  # start at 2000
fi

INDEX=$(( (INDEX + 1) % ${#DPIS[@]} ))
DPI=${DPIS[$INDEX]}
echo "$INDEX" > "$STATE_FILE"

notify-send -a "Mouse DPI" -t 2000 "DPI: $DPI" --icon=input-mouse

solaar config "MX Master 3 Wireless Mouse" dpi "$DPI"
