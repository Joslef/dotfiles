#!/bin/bash
# Runs periodically to write the next calendar event to a file
# This script should be called from a context with Calendar TCC access
OUTFILE="/tmp/sketchybar_next_event"
EVENT=$(/opt/homebrew/bin/icalBuddy -n -li 1 -nc -nrd -eed -ea -df '' -tf '%H:%M' -iep 'datetime,title' -po 'datetime,title' -b '' -ps '/ /' eventsToday 2>/dev/null)
echo "$EVENT" > "$OUTFILE"
