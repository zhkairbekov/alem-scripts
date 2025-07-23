#!/bin/bash
#Автоматическое изменение языка раскладки на английский при заблокированном экране 🥰 P.S: С любовью Bauka (basagitz)

#Установка
# 1. Создайте файл с расширением .desktop в каталоге ~~/home/student/.config/autostart/you_custom_file_name.desktop
# 2. Вставьте следующее содержимое в созданный .desktop файл:
# 
# [Desktop Entry]
# Type=Application
# Exec=/path/to/your/script.sh  # Измените путь на расположение этого скрипта
# Hidden=false
# NoDisplay=false
# X-GNOME-Autostart-enabled=true
# Name=My Script
# Comment=Start my script at login

# Запуск фонового процесса для автоматического изменения раскладки
nohup bash -c '
while true; do
    if pgrep -x "i3lock" > /dev/null; then
       setxkbmap -layout us
    else
       setxkbmap -layout us,ru -option "grp:alt_shift_toggle"
    fi
    sleep 5
done
' > /dev/null 2>&1 & disown
