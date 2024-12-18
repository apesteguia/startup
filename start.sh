#!/bin/bash

USUARIO=$USER
DISTRO="$1"
PACKAGES="gcc gdb clang git curl wget neovim vim awesome luarocks zsh nodejs npm ripgrep fzf tree htop neofetch go chromium tmux alacritty thunar flameshot erlang elixir awesome"

#install needed packages
case "$DISTRO" in 
	debian)
		sudo apt update -y
		sudo apt upgrade -y
		sudo apt install $PACKAGES 
		;;
	fedora)
		sudo dnf update -y
		sudo dnf in $PACKAGES 
		;;
	arch)
		sudo pacman -Syu
		sudo pacman -S $PACKAGES 
		;;
	*)
		echo "Distro no soportada"
		;;
esac

# clone my configs
cd ~/.config
git clone https://github.com/apesteguia/configs
git clone https://github.com/apesteguia/nvim
git clone https://github.com/apesteguia/awesome

cp configs/.tmux.conf ~/
cp configs/.wezterm.lua ~/
mkdir ~/.config/alacritty
cp configs/alacritty.toml ~/.config/alacritty/
cp configs/mikel.zsh-theme ~/.oh-my-zsh/themes/

# oh my zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# setup zsh
sudo chsh -s /bin/zsh root
sudo chsh -s /bin/zsh $USUARIO

#install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

