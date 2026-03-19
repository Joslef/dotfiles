#!/bin/bash
current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
if [ "$1" = "up" ]; then
    target=$(( (current / 5) * 5 + 5 ))
    if [ $target -gt 100 ]; then target=100; fi
else
    target=$(( ( (current + 4) / 5) * 5 - 5 ))
    if [ $target -lt 0 ]; then target=0; fi
fi
wpctl set-volume @DEFAULT_AUDIO_SINK@ "${target}%"
