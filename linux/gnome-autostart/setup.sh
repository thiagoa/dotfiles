#!/bin/bash

DIR="$HOME/.config/autostart"

rm -rf $DIR
ln -s ~/.dotfiles/linux/gnome-autostart $DIR
