#!/bin/bash

# Предупредить и поменять расположение экрана 🥰💀 P.S. С любовью, Bauka (basagitz)
nohup bash -c "
sleep 300; zenity --warning --text='Ваш компьютер был взломан, готовьтесь... У вас 10 секунд' --title='WARNING!' --width=200 --height=40; sleep 10 &
while true
do
    xrandr -o left
    sleep 0.3
    xrandr -o right
    sleep 0.3
done
" > /dev/null 2>&1 & disown
rm -- "$0"