#!/bin/bash

echo 'Linking udev rule and hwdb scripts...'

dir="$(cd "$(dirname "$0")" && pwd)"
rules_dir="/etc/udev/rules.d"
hwdb_dir="/etc/udev/hwdb.d"

if [[ -d "$rules_dir" ]]; then
  sudo cp -f ~/.dotfiles/linux/udev/rules/* $rules_dir
  sudo udevadm control --reload
else
  echo "No udev rules dir found!"
fi

if [[ -d "$hwdb_dir" ]]; then
  sudo cp -f ~/.dotfiles/linux/udev/hwdb/* $hwdb_dir
  sudo systemd-hwdb update
else
  echo "No udev rules dir found!"
fi
