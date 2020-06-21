#!/bin/bash

dest="$HOME/Code/linux/xkeysnail"

if [[ ! -d "$dest" ]]; then
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
