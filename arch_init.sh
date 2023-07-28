#!/bin/bash

# ====================
# Installation
sudo pacman -Syu

# CLI tools
sudo pacman -S --noconfirm --needed base-devel zsh zsh-syntax-highlighting noto-fonts noto-fonts-cjk alacritty python python-pynvim python-pip htop feh nodejs npm neofetch

# GUI tools
sudo pacman -S --noconfirm --needed nvidia xorg-xinit xmonad xmonad-contrib xmobar firefox rofi

# Aur helper
cd ~/ && git clone https://aur.archlinux.org/aura-bin.git && cd aura-bin
makepkg -s
sudo pacman -U *.pkg.tar.zst
cd ~/

# Kmonad
sudo aura -Axa kmonad-bin

# ====================
# Dotfiles
if ! [ -d ~/.config ]; then
        mkdir ~/.config
fi

if ! [ -d ~/.old ]; then
        mkdir ~/.old
fi

# alacritty
if [ -d ~/.config/alacritty ]; then
        mv ~/.config/alacritty ~/.old
else
        mkdir -p ~/.config/alacritty
fi
ln -s ~/Documents/Github/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

# neovim
if [ -d ~/.config/nvim ]; then
        mv ~/.config/nvim ~/.old
else
        mkdir -p ~/.config/nvim
fi
ln -s ~/Documents/Github/dotfiles/init.vim ~/.config/nvim/init.vim
if ! [ -d ~/.config/coc/ultisnips ]; then
        mkdir -p ~/.config/coc/ultisnips
fi
ln -s ~/Documents/Github/dotfiles/markdown.snippets ~/.config/coc/ultisnips/markdown.snippets
ln -s ~/Documents/Github/dotfiles/python.snippets ~/.config/coc/ultisnips/python.snippets

# oh-my-zsh
if [ -f ~/.zshrc ]; then
        mv ~/.zshrc ~/.old/.zshrc
fi
ln -s ~/Documents/Github/dotfiles/zshrc_arch ~/.zshrc

# xmonad
if [ -d ~/.config/xmonad ]; then
        mv ~/.config/xmonad ~/.old/
else
        mkdir -p ~/.config/xmonad
fi
ln -s ~/Documents/Github/dotfiles/xmonad.hs ~/.config/xmonad/xmonad.hs

# xmobar
if [ -d ~/.config/xmobar ]; then
        mv ~/.config/xmobar ~/.old/
else
        mkdir -p ~/.config/xmobar
fi
ln -s ~/Documents/Github/dotfiles/xmobarrc ~/.config/xmobar/xmobarrc

# kmonad
if [ -d ~/.config/kmonad ]; then
        mv ~/.config/kmonad ~/.old/
else
        mkdir -p ~/.config/kmonad
fi
ln -s ~/Documents/Github/dotfiles/kmonad.kbd ~/.config/kmonad/kmonad.kbd
sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
sudo touch /etc/udev/rules.d/50-kmonad.rules
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/50-kmonad.rules

# xinit
if [ -f ~/.xinitrc ]; then
        mv ~/.xinitrc ~/.old/.xinitrc
fi
ln -s ~/Documents/Github/dotfiles/xinitrc ~/.xinitrc

# Autostart X at login
if [ -f ~/.zprofile ]; then
        mv ~/.zprofile ~/.old/.zprofile
fi
ln -s ~/Documents/Github/dotfiles/zprofile ~/.zprofile

# ====================
# Initialization
fc-cache -f # refresh fonts
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' # vim-plug
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh-my-zsh
