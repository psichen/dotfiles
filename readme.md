# MacOS #

## Softwares to install via brew ##
* Alacritty
* AIDente
* BibDesk
* Blender
* GoldenDict
* Karabiner
* Microsoft-office
* Neovim
* Rectangle
* sioyek
* Stats

## Python configuration ##
MacOS (Ventura) comes with Python3 by default. The virtual environment `dev` can be created by `python3 -m venv Documents/dev`

After install `zsh` and `Oh My Zsh`, add these alias in `.zshrc`:

`alias pip="python3 -m pip"`

`alias dev="source ~/Documents/dev/bin/activate"`

`alias base="deactivate"`

Add plugins:

`plugins=(git macos vi-mode)`

## PyQt5 in M1 ##

`pyqt5` can not be installed via `pip` on M1 macbooks because `pip` doesn't provide the corresponding wheel file. To resolve this issue, we can install `pyqt6` via `pip`, which natively supports M1 chips.

## Installation ##

### Alacritty ###
The config file should be located at:
`$HOME/.config/alacritty/alacritty.yml`

The config template can be found [here](https://github.com/alacritty/alacritty/releases) to change font size.

### BibDesk ###

`Cite Key Format`:`%a1%Y%T1`

Check `File papers relative to each document` and `File papers automatically`.

`AutoFile`:`Papers/%Y_%t0%u0%e`

`Clean by removing`:`Non-ASCII`

### GoldenDict ###
Put dictionareis in `/Applications/GoldenDict.app/Contents/Resources/dict` and load them in GoldenDict.

### Karabiner ###
Install `Goku` via brew. Notably, `Rosseta` is required for running `Goku` in M1 Macbooks.

Put `Karabiner.edn` in `$HOME/.config/` and run `goku` in terminal.

For the HHKB keyboard, press `Fn`+`q` to reconnect.

### Neovim ###

Put the config file `init.vim` in the path `$HOME/.config/nvim/` and install plugins by `:PlugInstall` in `vim-plug`.

The plug `coc.nvim` requires `node`, which can be installed via brew.

Install `pynvim` via `pip install pynvim`.

Then, install coc extensions such as `coc-pyright` and `coc-snippets`

Put custom `*.snippets` in `$HOME/.config/coc/ultisnips/` to enable custom snippets completion.

`npm -g install instant-markdown-d` for the plugin `instant-markdown-d`.

### sioyek ###

Link config fiels `prefs_user.config` and `keys_user.config` to `~/.config/sioyek/`.

Notably, the `shared.db` is located in Onedrive `/Users/psichen/Library/CloudStorag/OneDrive-med.cornell.edu/Literatures/shared.db`

# Ubuntu #

Using `git clone` to download corresponding plugins in the directory `.oh-my-zsh/custom/plugins/`. Then add the plugin name in `.zshrc`.

Install `haskell-stack` from repository to build and install haskell applications like `KMonad` and `XMonad`.

## KMonad ##
Install `KMonad` from source via `stack install` and add the installed path to `$PATH`.

get `uinput` permission via:
```
sudo groupadd uinput
sudo usermod -aG input username
sudo usermod -aG uinput username
```

add a udev rule in `/etc/udev/rules.d/50-kmonad.rules`:
```
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
```

check the `uinput` drivers are loaded: `sudo modprobe uinput`

Check the `input` in the KMonad configuration file and the path `/dev/input/by-id/*-kbd`.

A reboot may be needed.

touch a file `~/.xsessionrc` and add `kmonad Path/To/KMonad/Configure/file.kbd`.

## XMonad ##
`sudo apt install xmonad` and change the session to `xmonad` after logout.
Configure file `~/.xmonad/xmonad.hs`
