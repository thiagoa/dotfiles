#!/usr/bin/env bash

source_file="$HOME/.dotfiles/linux/amdgpu/config/10-amdgpu.conf"
dest_file="/usr/share/X11/xorg.conf.d/10-amdgpu.conf"

if [[ -f "$source_file" ]]; then
  if [[ ! -f "${dest_file}.backup" ]]; then
    sudo cp "$dest_file" "${dest_file}.backup"
  fi

  sudo cp -f "$source_file" "$dest_file"
fi
