#!/bin/bash

dest="$HOME/Code/linux/xkeysnail"

if [[ ! -d "$dest" ]] || [[ -n "$FORCE" ]]; then
  echo 'Installing xkeysnail...'

  if ! which pip3 > /dev/null 2>&1; then
    echo 'ERROR: Please, install pip3'
    exit 1
  fi

  git clone -q git@github.com:thiagoa/xkeysnail $dest
  cd $dest
  git fetch -q &> /dev/null
  git checkout -q -b fixes origin/fixes
  sudo pip3 -q install --upgrade .
fi

dest_dir="$HOME/.xkeysnail"
source="$HOME/.dotfiles/linux/xkeysnail/custom_win_ids.py"
dest="$dest_dir/custom_win_ids.py"

if [[ ! -f "$dest" ]]; then
  mkdir -p "$dir"
  cp "$source" "$dest"
fi
