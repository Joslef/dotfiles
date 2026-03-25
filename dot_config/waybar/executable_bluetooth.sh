#!/usr/bin/env bash
# Bluetooth rotation widget for waybar
# Rotates through connected devices every minute
# Returns JSON with text (current device + battery) and tooltip (all devices aligned)

get_battery() {
    local mac="$1"
    local name="$2"
    local mac_colon="${mac}"
    # Convert to uppercase for matching (bluetoothctl gives uppercase MACs)
    local mac_upper="${mac_colon^^}"
    local mac_under="${mac_upper//:/_}"

    # Match upower device by native-path containing the MAC
    while IFS= read -r upath; do
        native=$(upower -i "$upath" 2>/dev/null | awk '/native-path/{print $2}')
        # native-path ends with /dev_XX_XX_XX (MAC with underscores, uppercase)
        native_mac="${native##*/dev_}"
        if [[ "${native_mac}" == "${mac_under}" ]]; then
            upower -i "$upath" 2>/dev/null | awk '/percentage/{print $2}'
            return
        fi
    done < <(upower -e | grep -v DisplayDevice | grep -v line_power | grep -v battery_CMB)

    # Fallback: match by model name
    while IFS= read -r upath; do
        model=$(upower -i "$upath" 2>/dev/null | awk '/[[:space:]]model:/{$1=""; sub(/^ /, ""); print}')
        if [[ -n "$model" && ("$name" == *"$model"* || "$model" == *"$name"*) ]]; then
            upower -i "$upath" 2>/dev/null | awk '/percentage/{print $2}'
            return
        fi
    done < <(upower -e | grep -v DisplayDevice | grep -v line_power | grep -v battery_CMB)

    echo "??"
}

# Get connected devices
mapfile -t devices < <(bluetoothctl devices Connected 2>/dev/null | sed 's/^Device //')

if [[ ${#devices[@]} -eq 0 ]]; then
    printf '{"text": "󰂱", "tooltip": "No devices connected"}\n'
    exit 0
fi

declare -a names
declare -a batteries

for entry in "${devices[@]}"; do
    mac=$(echo "$entry" | awk '{print $1}')
    name=$(echo "$entry" | cut -d' ' -f2-)
    battery=$(get_battery "$mac" "$name")
    names+=("$name")
    batteries+=("$battery")
done

count=${#names[@]}

# Rotate based on current minute
minute=$(date +%-M)
idx=$(((minute / 15) % count))

current_name="${names[$idx]}"
current_battery="${batteries[$idx]}"

# Build tooltip with all devices, battery in aligned column
max_len=0
for name in "${names[@]}"; do
    len=${#name}
    [[ $len -gt $max_len ]] && max_len=$len
done

tooltip=""
for i in "${!names[@]}"; do
    printf -v padded "%-${max_len}s" "${names[$i]}"
    line="${padded}  ${batteries[$i]}"
    if [[ -n "$tooltip" ]]; then
        tooltip="${tooltip}\\n${line}"
    else
        tooltip="${line}"
    fi
done

printf '{"text": "󰂱  %s  %s", "tooltip": "%s"}\n' \
    "$current_name" \
    "$current_battery" \
    "${tooltip//\"/\\\"}"
