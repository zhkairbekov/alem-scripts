#!/bin/bash

# Define the password
password="your password"

# Run the lock_screen command
/usr/local/bin/lock_screen &

# Wait a moment for the lock_screen to prompt for input
sleep 1

# Simulate typing the password twice using xdotool
xdotool type "$password"
xdotool key Return
xdotool type "$password"
xdotool key Return

# Wait for the AFK message screen to appear (adjust the sleep duration if needed)
sleep 2

# Close the AFK message screen (if it's a window that can be closed with Alt+F4)
xdotool key Alt+F4
