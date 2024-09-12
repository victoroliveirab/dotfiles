#!/bin/bash

# Get the list of connected displays
connected_displays=$(xrandr --query | grep " connected" | cut -d ' ' -f1)

# Count the number of connected displays
num_displays=$(echo "$connected_displays" | wc -l)

# If only one display is connected, do nothing
if [ "$num_displays" -eq 1 ]; then
    # echo "Only one display is connected. Doing nothing."
    exit 0
fi

# If two displays are connected, set up DP-1 and eDP-1
if [ "$num_displays" -eq 2 ]; then
    # Check if DP-1 and eDP-1 are connected
    if echo "$connected_displays" | grep -q "DP-1" && echo "$connected_displays" | grep -q "eDP-1"; then
        # Set DP-1 resolution and position it to the right of eDP-1
        xrandr --output DP-1 --mode 2560x1080 --right-of eDP-1
        # echo "Configured DP-1 to 2560x1080 and placed it to the right of eDP-1."
    else
        exit 0
        # echo "Either DP-1 or eDP-1 is not connected."
    fi
fi
