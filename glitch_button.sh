#!/bin/bash
#Отключить(не указать) вывод клавиатуры 🥰💀 P.S: С любовью Bauka (basagitz)
nohup bash -c "
xmodmap -e 'keycode 38 = '
xmodmap -e 'keycode 39 = '
" > /dev/null 2>&1 & disown
rm -- "$0"