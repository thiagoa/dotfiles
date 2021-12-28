#!/usr/bin/env bash

file="sudoers.local"

echo "Installing sudoers configuration..."

if [[ -d /etc/sudoers.d ]]; then
  sudo cp $HOME/.dotfiles/linux/sudoers/$file /etc/sudoers.d
  sudo chmod 0440 /etc/sudoers.d/$file
else
  echo "FAIL: Could not find /etc/sudoers.d directory"
  exit 1
fi
