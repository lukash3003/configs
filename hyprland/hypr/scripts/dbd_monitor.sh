#!/bin/bash
WINDOW_CLASS="DeadByDaylight"  # Replace with your game's class
LAST_STATE="hidden"

while true; do
    # Get window state
    CURRENT_STATE=$(hyprctl clients | awk -v cls="$WINDOW_CLASS" '
        BEGIN { RS=""; FS="\n" }
        $0 ~ "class: " cls {
            mapped=0; hidden=0
            for (i=1; i<=NF; i++) {
                if ($i ~ "mapped: 1") mapped=1
                if ($i ~ "hidden: 1") hidden=1
            }
            if (mapped && !hidden) print "visible"
            else print "hidden"
            exit
        }
    ')

    # Trigger notification on state change
    if [[ "$LAST_STATE" == "hidden" && "$CURRENT_STATE" == "visible" ]]; then
        notify-send "Dead by Daylight is ready!"
    fi
    LAST_STATE="$CURRENT_STATE"
    sleep 2
done
