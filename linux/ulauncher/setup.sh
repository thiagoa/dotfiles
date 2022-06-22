#!/bin/bash

dir="$(cd "$(dirname "$0")" && pwd)"
backup_ui_dir="$dir/ui"

if [[ -d "$HOME/Dropbox/Linux/ulauncher-config" ]]; then
  ln -sfn $HOME/Dropbox/Linux/ulauncher-config $HOME/.config/ulauncher
fi
