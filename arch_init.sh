#!/bin/bash

# initialize Arch
sudo pacman -Syu

# CLI tools
sudo pacman -S --noconfirm zsh noto-fonts noto-fonts-cjk alacritty python python-pynvim python-pip htop feh

# GUI tools
sudo pacman -S --noconfirm nvidia xorg-xinit xmonad xmonad-contrib xmobar firefox rofi

# dotfiles
if [ ! -d ~/.config ]; then
        mkdir ~/.config
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh-my-zsh

# nvidia, kmonad require reboot
