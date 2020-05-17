#!/bin/bash

echo 'Linking udev rule scripts...'

dir="$(cd "$(dirname "$0")" && pwd)"
rules_dir="/etc/udev/rules.d"

if [[ -d "$rules_dir" ]]; then
  sudo cp -f ~/.dotfiles/linux/udev/* $rules_dir
  sudo udevadm control --reload
else
  echo "No udev found!"
fi
