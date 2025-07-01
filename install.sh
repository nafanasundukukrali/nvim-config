#!/bin/bash

# Установка Vim
sudo apt update && sudo apt install -y vim nodejs npm curl
echo "Vim установлен"

# Копируем .vimrc в домашнюю директорию
if [ -f ".vimrc" ]; then
    cp .vimrc ~/
    echo ".vimrc скопирован в домашнюю директорию"
else
    echo "Ошибка: файл .vimrc не найден в текущей директории"
    exit 1
fi

echo "Устанавливаем vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Устанавливаем плагины из .vimrc..."
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"

npm install -g pyright bash-language-server vscode-langservers-extracted

# Для C/C++ (clangd)
sudo apt install -y clangd-12
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100

echo "Done."
