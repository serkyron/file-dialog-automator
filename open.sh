#!/bin/bash

file=$1
browser="chrome"
win_name="Open File"
default_sleep=3
type_delay=700

# Find window PID
WIN=$(for pid in $(xdotool search --class "$browser"); do if [[ $(xdotool getwindowname $pid) == "$win_name" ]]; then echo $pid; fi; done)

if [ -z "$WIN" ]
then
	echo "$win_name window not found!" 1>&2
	exit 1 # window not found
fi

# Switch to the window
xdotool windowactivate $WIN
sleep $default_sleep

# Send file path
xdotool type --clearmodifiers --delay=$type_delay "$file"
sleep $default_sleep

# Press "Open" button
xdotool key alt+o
sleep $default_sleep

# Ensure window is closed
WIN=$(for pid in $(xdotool search --class "$browser"); do if [[ $(xdotool getwindowname $pid) == "$win_name" ]]; then echo $pid; fi; done)

if [ ! -z "$WIN" ]
then
	echo "Failed to open file for unknown reason!" 1>&2
	xdotool key "Escape"
	xdotool key "Escape"
	xdotool key "Escape"
	exit 2 # failed to open file
fi
