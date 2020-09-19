#!/bin/bash

file=$1
browser="chrome"
win_name="Open File"

# Find window PID
WIN=$(for pid in $(xdotool search --class "$browser"); do if [[ $(xdotool getwindowname $pid) == "$win_name" ]]; then echo $pid; fi; done)

# Switch to the window
xdotool windowactivate $WIN
sleep 3

# Send file path
xdotool type --clearmodifiers --delay=500 "$file"
sleep 3

# Press "Open" button
xdotool key alt+o
