#!/bin/bash

BG=$(find "$HOME/.config/hypr/hyprlockbackground/" -maxdepth 1 -name "background.*" -type f | head -1)
CONF=$(mktemp /tmp/hyprlock-XXXXXX.conf)

sed "s|path = .*|path = $BG|" "$HOME/.config/hypr/hyprlock.conf" > "$CONF"
hyprlock --config "$CONF"

rm -f "$CONF"
