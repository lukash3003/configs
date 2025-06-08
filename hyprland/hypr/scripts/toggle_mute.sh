#!/usr/bin/env bash

# Get active window PID
ACTIVE_WINDOW=$(hyprctl -j activewindow)
echo "Active window info: $ACTIVE_WINDOW"  # Debug line
PID=$(echo "$ACTIVE_WINDOW" | jq -r '.pid')
echo "PID: $PID"  # Debug line

[ -z "$PID" ] && echo "No PID found!" && exit 1  # Debug line

# Find sink input
SINK_INPUT=$(pactl list sink-inputs | awk -v pid="$PID" '
  BEGIN { sink_id = ""; found = 0 }
  /^Sink Input #/ { sink_id = $3 }
  /application.process.id = "/ { 
    split($3, arr, "\"");
    if (arr[2] == pid) {
      print sink_id;
      found = 1;
      exit;
    }
  }
  END { if (!found) exit 1 }
')

# Check if sink input was found
if [ -n "$SINK_INPUT" ]; then
  echo "Toggling mute for sink input: $SINK_INPUT"  # Debug line
  pactl set-sink-input-mute "$SINK_INPUT" toggle
else
  echo "No sink input found for PID $PID"  # Debug line
fi
