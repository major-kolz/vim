#!/bin/bash

# Configure GVim (installation or updating) by soft links (original on this directory)

current=$( dirname "$0" )
vdir=$HOME/.vim

ln -s "$current/.vimrc" -t "$HOME"
ln -s "$current/ftplugin" -t "$vdir"
ln -s "$current/keymap" -t "$vdir"
ln -s "$current/spell" -t "$vdir"
ln -s "$current/syntax" -t "$vdir"

notyfi-send "--expire-time=3000" "Vim configuration" "Done"
