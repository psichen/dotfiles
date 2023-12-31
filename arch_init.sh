#!/bin/bash

# ====================
# Installation oh-my-zsh first
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh-my-zsh
# ====================
sudo pacman -Syu

# CLI tools
sudo pacman -S --noconfirm --needed base-devel zsh noto-fonts noto-fonts-cjk alacritty python python-pynvim python-pip htop nvtop feh nodejs npm neofetch neovim openssh pandoc-cli ranger reflector

# GUI tools
sudo pacman -S --noconfirm --needed nvidia cuda xorg-xinit xmonad xmonad-contrib xmobar firefox rofi qt6-base

# Aur helper
cd ~/ && git clone https://aur.archlinux.org/aura-bin.git && cd aura-bin
makepkg -s
sudo pacman -U *.pkg.tar.zst
cd ~/

# Kmonad
sudo aura -Axa kmonad-bin

# Sioyek
 sudo aura -Axa sioyek

# ====================
# Dotfiles
if ! [ -d $HOME/.config ]; then
        mkdir $HOME/.config
fi

if ! [ -d $HOME/.old ]; then
        mkdir $HOME/.old
fi

# alacritty
if [ -d $HOME/.config/alacritty ]; then
        mkdir -p $HOME/.old/alacritty && mv $HOME/.config/alacritty/* $HOME/.old/alacritty/
else
        mkdir -p $HOME/.config/alacritty
fi
ln -s $HOME/Documents/Github/dotfiles/alacritty.toml $HOME/.config/alacritty/alacritty.toml

# neovim
if [ -d $HOME/.config/nvim ]; then
        mkdir -p $HOME/.old/nvim && mv $HOME/.config/nvim/* $HOME/.old/nvim/
else
        mkdir -p $HOME/.config/nvim
fi
ln -s $HOME/Documents/Github/dotfiles/init.vim $HOME/.config/nvim/init.vim
if ! [ -d $HOME/.config/coc/ultisnips ]; then
        mkdir -p $HOME/.config/coc/ultisnips
fi
ln -sf $HOME/Documents/Github/dotfiles/markdown.snippets $HOME/.config/coc/ultisnips/markdown.snippets
ln -sf $HOME/Documents/Github/dotfiles/python.snippets $HOME/.config/coc/ultisnips/python.snippets

# xmonad
if [ -d $HOME/.config/xmonad ]; then
        mkdir -p $HOME/.old/xmonad && mv $HOME/.config/xmonad/* $HOME/.old/xmonad/
else
        mkdir -p $HOME/.config/xmonad
fi
ln -s $HOME/Documents/Github/dotfiles/xmonad.hs $HOME/.config/xmonad/xmonad.hs

# xmobar
if [ -d $HOME/.config/xmobar ]; then
        mkdir -p $HOME/.old/xmobar && mv $HOME/.config/xmobar/* $HOME/.old/xmobar/
else
        mkdir -p $HOME/.config/xmobar
fi
ln -s $HOME/Documents/Github/dotfiles/xmobarrc $HOME/.config/xmobar/xmobarrc

# kmonad
if [ -d $HOME/.config/kmonad ]; then
        mkdir -p $HOME/.old/kmonad && mv $HOME/.config/kmonad/* $HOME/.old/kmonad/
else
        mkdir -p $HOME/.config/kmonad
fi
ln -s $HOME/Documents/Github/dotfiles/kmonad.kbd $HOME/.config/kmonad/kmonad.kbd
sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
sudo touch /etc/udev/rules.d/50-kmonad.rules
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/50-kmonad.rules
sudo touch /etc/modules-load.d/uinput.conf
echo "uinput" | sudo tee /etc/modules-load.d/uinput.conf

 # ranger
 ranger --copy-config=rifle
 echo 'ext pdf, has sioyek, X, flag f = sioyek "$@"' > $HOME/.config/ranger/rifle.conf

 # sioyek
if [ -d $HOME/.config/sioyek ]; then
        mkdir -p $HOME/.old/sioyek && mv $HOME/.config/sioyek/* $HOME/.old/sioyek/
else
        mkdir -p $HOME/.config/sioyek
fi
ln -s $HOME/Documents/Github/dotfiles/keys_user.config $HOME/.config/sioyek/keys_user.config
ln -s $HOME/Documents/Github/dotfiles/prefs_user.config $HOME/.config/sioyek/prefs_user.config

# xinit
if [ -f $HOME/.xinitrc ]; then
        mv $HOME/.xinitrc $HOME/.old/.xinitrc
fi
ln -s $HOME/Documents/Github/dotfiles/xinitrc $HOME/.xinitrc

# Autostart X at login
if [ -f $HOME/.zprofile ]; then
        mv $HOME/.zprofile $HOME/.old/.zprofile
fi
ln -s $HOME/Documents/Github/dotfiles/zprofile $HOME/.zprofile

# ====================
# Initialization
fc-cache -f # refresh fonts
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' # vim-plug
python -m venv $HOME/Documents/dev # python virtual environment
sudo systemctl enable sshd
sudo reflector --latest 3 --sort rate --save /etc/pacman.d/mirrorlist
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# oh-my-zsh
if [ -f $HOME/.zshrc ]; then
        mv $HOME/.zshrc $HOME/.old/.zshrc
fi
ln -s $HOME/Documents/Github/dotfiles/zshrc_arch $HOME/.zshrc
