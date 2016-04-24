#!/bin/bash

# Configure GVim (installation or updating) by soft links 
# (original is in directory of this repo)

current=`dirname $(realpath $0)`
mkdir -p $HOME/.vim
vdir=$HOME/.vim/

installer="apt-get install"
if command -v pacman 2> /dev/null
then
	installer="pacman --needed -S"
fi

ln -s "$current/.vimrc" -t "$HOME"
ln -s "$current/ftplugin" -t "$vdir"
ln -s "$current/keymap" -t "$vdir"
ln -s "$current/spell" -t "$vdir"
ln -s "$current/syntax" -t "$vdir"
ln -s "$current/snippets" -t "$vdir"

if [ ! -f "$vdir/autoload/plug.vim" ]; then
	if [ ! hash curl 2> /dev/null ]; then
		notify-send "--expire-time=3000" "Vim configuration" "Please install 'curl'"
		sudo -A $installer curl
	fi
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
fi

notify-send "--expire-time=3000" "Vim configuration" "Done. Download plugins"
