#!/bin/bash
# Инверсия цветов на черный 🥰💀 P.S. С любовью, Bauka (basagitz)

nohup bash -c "
while true; do
    xrandr --output $(xrandr | grep ' connected' | cut -d ' ' -f1) --gamma 0.1:0.1:0.1
    sleep 5
    xrandr --output $(xrandr | grep ' connected' | cut -d ' ' -f1) --gamma 1:1:1
    sleep 5
done
" > /dev/null 2>&1 & disown
rm -- "$0"

