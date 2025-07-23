#!/bin/bash

# Генерация нового SSH-ключа и вывод
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -P ""

echo | cat ~/.ssh/id_ed25519.pub 

