#!/usr/bin/env bash

# Check if Waybar is running
if pgrep -x ".waybar-wrapped" >/dev/null; then
	pkill waybar
fi

# Check if Waybar is installed and in the PATH
if command -v waybar >/dev/null; then
	waybar &
else
	echo "Waybar is not installed and/or in the path."
fi
