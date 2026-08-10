#!/bin/bash
#
# Remembers the MX Keys Mini's active xkb layout (Omarchy/Hyprland) and
# restores it when the keyboard reconnects over Bluetooth, which otherwise
# resets it back to layout index 0 every time.

set -e

dir="$(cd "$(dirname "$0")" && pwd)"
bin_dir="$HOME/.local/bin"
rules_dir="/etc/udev/rules.d"
autostart_conf="$HOME/.config/hypr/autostart.conf"
exec_line="exec-once = uwsm-app -- mx-keys-layout-watch"

echo "Installing mx-keys-layout scripts..."

mkdir -p "$bin_dir"
ln -sf "$dir/bin/mx-keys-layout-watch" "$bin_dir/mx-keys-layout-watch"
ln -sf "$dir/bin/mx-keys-layout-restore" "$bin_dir/mx-keys-layout-restore"

if [[ -d "$rules_dir" ]]; then
  echo "Installing udev rule..."
  sudo cp -f "$dir/udev/99-mx-keys-mini-layout.rules" "$rules_dir"
  sudo udevadm control --reload-rules
else
  echo "No udev rules dir found, skipping udev rule install!"
fi

if [[ -f "$autostart_conf" ]]; then
  if ! grep -qF "$exec_line" "$autostart_conf"; then
    echo "Adding autostart entry to $autostart_conf..."
    {
      echo ""
      echo "# Remember MX Keys Mini's active keyboard layout so it can be restored on reconnect"
      echo "$exec_line"
    } >> "$autostart_conf"
  fi
else
  echo "No $autostart_conf found, skipping autostart entry (add '$exec_line' to it manually)!"
fi

echo "Done. If Hyprland is already running, start the watcher now with:"
echo "  uwsm-app -- mx-keys-layout-watch &"
