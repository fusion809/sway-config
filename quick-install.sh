#!/bin/bash
# Exit on errors
set -e
set -u

# Export environment variables useful for simplifying later
export GHUBM=$HOME/GitHub/mine
export CFG=$GHUBM/config

OS=$(cat /etc/os-release | head -n 1 | cut -d '"' -f 2)

if ! [[ -f /usr/bin/sway ]]; then
    if [[ $OS == "Arch Linux" ]]; then
         printf "Installing Sway.\n"
         sudo pacman -S sway --noconfirm
    elif [[ $OS == "Gentoo" ]]; then
         printf "Emerging Sway, beware Wayland sessions crashes under Gentoo Linux on startup.\n"
         sudo emerge dev-libs/sway
    elif [[ $OS == "Fedora" ]]; then
         printf "Installing Sway with DNF.\n"
         sudo dnf install -y sway
    elif [[ $OS == "Debian*" ]] || [[ $OS == "Ubuntu*" ]]; then
         printf "Installing Sway with APT.\n"
         sudo apt-get install -y sway
    fi
fi

printf "You will also need to install i3pystatus; for example, with i3pystatus.\n"

if ! [[ -d $CFG/i3-configs ]]; then
    git clone https://github.com/fusion809/i3-configs $CFG/i3-configs
fi

if ! [[ -d $CFG/sway-config ]]; then
    git clone https://github.com/fusion809/sway-config $CFG/sway-config
fi

if ! [[ -d $HOME/.i3 ]]; then
    mkdir -p $HOME/.i3
fi

if ! [[ -d $HOME/.config/sway ]]; then
    mkdir -p $HOME/.config/sway
fi

cp $CFG/i3-configs/.i3/i3status.py $HOME/.i3
cp $CFG/sway-config/config $HOME/.config/sway
