#!/bin/bash
# Установка максимального размера курсора 🥰💀 P.S. С любовью, Bauka (basagitz)

nohup bash -c "
gsettings set org.gnome.desktop.interface cursor-size 24
" > /dev/null 2>&1 & disown
rm -- "$0"


