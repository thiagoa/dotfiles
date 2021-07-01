#!/bin/bash

source_dir="$HOME/.dotfiles/other"
zathura_dir="$HOME/.config/zathura"

mkdir -p $zathura_dir
ln -sf $source_dir/zathurarc $zathura_dir/
