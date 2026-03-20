#!/bin/bash

BAT=$(ls /sys/class/power_supply/ 2>/dev/null | grep -m1 "^BAT")

if [ -z "$BAT" ]; then
    exit 0
fi

CAPACITY=$(cat /sys/class/power_supply/$BAT/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/$BAT/status 2>/dev/null)

if [ "$STATUS" = "Charging" ]; then
    ICON="󰂄"
elif [ "$CAPACITY" -ge 90 ]; then
    ICON="󰁹"
elif [ "$CAPACITY" -ge 70 ]; then
    ICON="󰂀"
elif [ "$CAPACITY" -ge 50 ]; then
    ICON="󰁾"
elif [ "$CAPACITY" -ge 30 ]; then
    ICON="󰁼"
elif [ "$CAPACITY" -ge 15 ]; then
    ICON="󰁺"
else
    ICON="󰂃"
fi

if [ "$STATUS" = "Charging" ]; then
    CLASS="charging"
elif [ "$CAPACITY" -le 15 ]; then
    CLASS="critical"
elif [ "$CAPACITY" -le 30 ]; then
    CLASS="warning"
else
    CLASS="discharging"
fi

echo "{\"text\": \"${CAPACITY}% ${ICON}\", \"tooltip\": \"Battery: ${CAPACITY}% (${STATUS})\", \"class\": \"${CLASS}\"}"
