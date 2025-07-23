#!/bin/bash
#Отключить(не указать) кнопки Shift и Ctrl 🥰💀 P.S: С любовью Bauka (basagitz)
nohup bash -c "
xmodmap -e 'keycode 50 ='
xmodmap -e 'keycode 37 ='
" > /dev/null 2>&1 & disown
rm -- "$0"