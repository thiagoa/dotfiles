#!/bin/bash

# Git templates
ln -sf $HOME/.dotfiles/git_template $HOME/.git_template

# Zathura config
source_dir="$HOME/.dotfiles/other"
zathura_dir="$HOME/.config/zathura"

mkdir -p $zathura_dir
ln -sf $source_dir/zathurarc $zathura_dir/
