#!/bin/bash

DIR="$HOME/.config/autostart"

rm -rf $DIR
ln -s ~/.dotfiles/gnome-autostart $DIR