#!/bin/sh

[ ! -d "$HOME/.local" ] && exit

source_dir=$HOME/.dotfiles/gnome-shortcuts

mkdir -p $HOME/.local/share/applications 2> /dev/null
sudo ln -fs $source_dir/*.desktop $HOME/.local/share/applications/
