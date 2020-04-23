#!/bin/bash

DIR="$HOME/.config/autostart"

if [[ -d "$DIR" ]]; then
  echo "Linking gnome autostart files..."
  find $DIR -xtype l -name '*.desktop' | xargs rm -f
  ln -sf ~/.dotfiles/gnome/autostart/*.desktop $DIR
fi
