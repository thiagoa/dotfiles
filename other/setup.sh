#!/bin/bash

# Git templates
if [[ ! -d $HOME/.git_template ]]; then
  ln -sf $HOME/.dotfiles/git_template $HOME/.git_template
fi

# Zathura config
source_dir="$HOME/.dotfiles/other"
zathura_dir="$HOME/.config/zathura"

mkdir -p $zathura_dir
ln -sf $source_dir/zathurarc $zathura_dir/
