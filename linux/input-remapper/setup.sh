#!/usr/bin/env bash

echo "---------------------------------------------"
echo " Installing input-remapper"
echo "---------------------------------------------"
echo

dir="$HOME/Code/linux/input-remapper"

if [[ ! -d "$dir" ]] || [[ -n "$FORCE" ]]; then
  rm -rf "$dir"
  sudo apt install git python3-setuptools gettext
  git clone https://github.com/sezanzeb/input-remapper.git "$dir"
  cd "$dir" && ./scripts/build.sh
  sudo apt install ./dist/*.deb
fi

echo
