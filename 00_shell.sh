#!/bin/bash

install_zsh () {
    if [ -x "$(command -v apt)" ];
    then
        sudo apt update
        sudo apt install -y "${packagesNeeded[@]}"
    elif [ -x "$(command -v dnf)" ];
    then
        sudo dnf install -y zsh
    elif [ -x "$(command -v zypper)" ];
    then
        sudo zypper install -y zsh
    else
        echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: zsh">&2;
    fi
}

# Install packages
## Ubuntu
echo "Installing Zsh packages"
install_zsh

Fonts
mkdir -p ~/.local/share/fonts
cp -r NerdFonts ~/.local/share/fonts

# Setup Zsh
## Oh my Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Plugins
git clone https://github.com/johanhaleby/kubetail.git ~/.oh-my-zsh/custom/plugins/kubetail

## Starship
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config && cp starship.toml ~/.config

## Run Zsh
cp .zshrc ~/
zsh
source ~/.zshrc
