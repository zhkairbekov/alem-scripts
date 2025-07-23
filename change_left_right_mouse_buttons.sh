#!/bin/bash
#Изменить правую и левую кнопки мыши 🥰💀 P.S: С любовью Bauka (basagitz)
nohup bash -c "
    xinput set-button-map 14 3 2 1 4 5 6 7 8 9
" > /dev/null 2>&1 & disown
rm -- "$0"