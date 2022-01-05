#!/usr/bin/env bash

set -e

source_dir=$HOME/.dotfiles/linux/dual-function-keys
dest_dir=$HOME/Code/c/dual-function-keys

if [[ ! -d "$dest_dir" ]] || [[ "$1" == "--force" ]]; then
  if [[ -d "$dest_dir" ]]; then
    rm -rf "$dest_dir"
  fi
    
  mkdir -p $dest_dir

  sudo apt install cmake libevdev-dev libudev-dev libyaml-cpp-dev libboost-dev

  git clone https://gitlab.com/interception/linux/tools $dest_dir/tools
  git clone https://gitlab.com/interception/linux/plugins/dual-function-keys $dest_dir/dual-function-keys

  mkdir $dest_dir/tools/build
  cd $dest_dir/tools/build
  cmake ..
  make
  sudo make install
  cd $dest_dir/dual-function-keys
  make && sudo make install
fi

cp -f $source_dir/dual-function-keys.yaml $HOME/.dual-function-keys.yaml 
sudo cp -f $source_dir/udevmon.yaml /etc/udevmon.yaml
sudo cp -f $source_dir/udevmon.service /etc/systemd/system/udevmon.service

sudo systemctl enable --now udevmon
