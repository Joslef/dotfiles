#!/bin/bash

app=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')

case "$app" in
    "ghostty")
        osascript -e 'tell application "Ghostty" to activate' -e 'tell application "System Events" to tell process "Ghostty" to keystroke "n" using command down' ;;
    "Finder"|"finder")
        osascript -e 'tell application "Finder" to activate' -e 'tell application "System Events" to tell process "Finder" to keystroke "n" using command down' ;;
    "Twilight"|"zen")
        /Applications/Twilight.app/Contents/MacOS/zen --new-window ;;
esac
