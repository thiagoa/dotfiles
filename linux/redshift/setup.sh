#!/usr/bin/env bash

file=$HOME/.config/redshift.conf

rm -f $file
cp -f $HOME/.dotfiles/linux/redshift/redshift.conf $file
