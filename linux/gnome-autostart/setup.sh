#!/bin/bash

DIR="$HOME/.config/autostart"

rm -rf $DIR
ln -s $HOME/.dotfiles/linux/gnome-autostart $DIR
