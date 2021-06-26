#!/bin/bash

rm -rf $HOME/.config/autorandr
ln -snf $HOME/.dotfiles/linux/autorandr/config $HOME/.config/autorandr

hooks_dir="/etc/xdr/autorandr"

sudo mkdir -p $hooks_dir 2> /dev/null
sudo cp $HOME/.dotfiles/linux/autorandr/hooks/postswitch $hooks_dir
