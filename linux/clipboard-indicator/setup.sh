#!/bin/bash

echo 'Installing clipboard-indicator xkeysnail hack...'

dir="$(cd "$(dirname "$0")" && pwd)"
ext_dir="$HOME/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com"

if [[ -d "$ext_dir" ]]; then
  sudo cp -f $HOME/.dotfiles/linux/clipboard-indicator/* $ext_dir
else
  echo "clipboard-indicator does not seem to be installed!"
fi
