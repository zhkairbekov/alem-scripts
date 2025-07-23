#!/bin/bash
# Color flashbang 🥰💀 P.S: С любовью Bauka (basagitz)
nohup bash -c "
while true; do
    xrandr --output DP-1 --gamma 10:10:10
    sleep 0.3
    xrandr --output DP-1 --gamma 1:1:1
    sleep 0.3
done
" > /dev/null 2>&1 & disown
rm -- "$0"
