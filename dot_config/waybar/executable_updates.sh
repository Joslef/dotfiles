#!/bin/bash
list=$(checkupdates 2>/dev/null)
count=$(echo "$list" | grep -c .)

if [ "$count" -eq 0 ]; then
    echo '{"text": "󰏔  0", "tooltip": "System up to date"}'
else
    tooltip=$(echo "$list" | head -30 | tr '\n' '\n')
    echo "{\"text\": \"󰏔  $count\", \"tooltip\": $(echo "$list" | head -30 | jq -Rs .)}"
fi
