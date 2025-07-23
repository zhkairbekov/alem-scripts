#!/bin/bash

# Добавить все файлы
git add .

# Спросить у пользователя комментарий коммита
read -p "Введите комментарий для коммита: " commit_msg

# Сделать коммит
git commit -m "$commit_msg"

# Определить текущую ветку
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Сделать push
git push origin "$current_branch"


# ./gitconfig.sh - для запуска