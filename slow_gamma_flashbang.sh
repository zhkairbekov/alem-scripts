#!/bin/bash
#Slow Gamma Flashbang 🥰💀 P.S: С любовью Bauka (basagitz)
nohup bash -c '
# Массив значений гаммы
gamma_values=(1 2 3 4 5 6 7 8 9)

while true; do
    # Увеличиваем гамму
    for value in "${gamma_values[@]}"; do
        xrandr --output DP-1 --gamma $value:$value:$value
        sleep 1
    done

    # Уменьшаем гамму
    for ((i=${#gamma_values[@]}-1; i>=0; i--)); do
        value=${gamma_values[$i]}
        xrandr --output DP-1 --gamma $value:$value:$value
        sleep 1
    done
done
' > /dev/null 2>&1 & disown
rm -- "$0"
