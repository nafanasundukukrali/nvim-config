#!/bin/bash

# Установка Vim

# Проверяем, передан ли аргумент (имя пользователя)
if [ $# -eq 0 ]; then
    echo "Ошибка: Укажите имя пользователя в качестве аргумента."
    echo "Пример: $0 username"
    exit 1
fi

TARGET_USER="$1"
TARGET_HOME=$(eval echo ~"$TARGET_USER")

# Проверяем существование пользователя через getent (работает с sudo)
if ! getent passwd "$TARGET_USER" >/dev/null; then
    echo "Ошибка: Пользователь '$TARGET_USER' не существует!"
    exit 1
fi

echo "Настройка Vim для пользователя: $TARGET_USER"
echo "Домашняя директория: $TARGET_HOME"

sudo apt update && sudo apt install -y git vim nodejs npm curl
echo "Vim установлен"

sudo npm install -g pyright bash-language-server vscode-langservers-extracted

echo "Копируем .vimrc в $TARGET_HOME..."

if [ -f ".vimrc" ]; then
    sudo cp .vimrc "$TARGET_HOME/"
    sudo chown "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/.vimrc"
    echo ".vimrc скопирован в $TARGET_HOME/"
    mkdir -p $TARGET_HOME/.vim/pack/plugins/start
    git clone --depth=1 https://github.com/rose-pine/vim $TARGET_HOME/.vim/pack/plugins/start/rosepine/
    echo "Установлена тема rose-pine"
else
    echo "Ошибка: Файл .vimrc не найден в текущей директории!"
    exit 1
fi

echo "Устанавливаем vim-plug..."

sudo -u "$TARGET_USER" curl -fLo "$TARGET_HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Устанавливаем плагины..."

sudo -u "$TARGET_USER" vim -es -u "$TARGET_HOME/.vimrc" -i NONE -c "PlugInstall" -c "qa"

sudo apt install -y clangd-14
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-14 100

echo "Done."
