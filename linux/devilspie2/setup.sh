#!/usr/bin/env bash

echo 'Installing devilspie2 config...'

SOURCE_DIR="$HOME/.dotfiles/linux/devilspie2"
DEST_DIR="$HOME/.config/devilspie2"

ln -fs $SOURCE_DIR $DEST_DIR
