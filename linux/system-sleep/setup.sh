#!/bin/bash

echo 'Linking system-sleep scripts...'

dir="$(cd "$(dirname "$0")" && pwd)"
system_sleep_dir="/usr/lib/systemd/system-sleep"

if [[ -d "$system_sleep_dir" ]]; then
  sudo cp -f $dir/scripts/* $system_sleep_dir
else
  echo "No system-sleep found!"
fi
