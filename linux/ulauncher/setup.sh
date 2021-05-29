#!/bin/bash

dir="$(cd "$(dirname "$0")" && pwd)"
backup_ui_dir="$dir/ui"
ulauncher_ui_dir="/usr/share/ulauncher/ui"

if [[ -d "$HOME/OneDrive/Linux/ulauncher-config" ]]; then
  ln -sfn $HOME/OneDrive/Linux/ulauncher-config $HOME/.config/ulauncher
fi

if [[ ! -d "$ulauncher_ui_dir" ]]; then
  exit
fi

if [[ "$1" == "--restore" ]]; then
  sudo apt-get --reinstall install ulauncher
  echo
  echo "Ulauncher Successfully restored"
  exit
fi

for path in `find $backup_ui_dir -type f -name *.ui`; do
  file=`basename $path`
  sudo cp $path $ulauncher_ui_dir/$file
done

echo "Ulauncher files copied successfully"

# if pgrep ulauncher > /dev/null; then
#   echo 'Restarting Ulauncher...'
#   killall ulauncher
#   sleep 2
#   ulauncher > /dev/null &
#   disown %1
# fi
