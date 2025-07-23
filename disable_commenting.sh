#!/bin/bash
#Отключить возможность комментирования/раскомментировывания 🥰💀 P.S: С любовью Bauka (basagitz)
nohup bash -c "
xmodmap -e 'keycode 37 = ' 
xmodmap -e 'keycode 61 = '
" > /dev/null 2>&1 & disown
rm -- "$0"