#!/usr/bin/env bash

sudoers_file="/etc/sudoers"
perm_prefix="thiago ALL=NOPASSWD:"
perms="$perm_prefix /usr/bin/openvpn*, /home/thiago/bin/xkeysnail*, /usr/local/bin/xkeysnail*, /usr/bin/xhost, /usr/bin/apt*, /usr/bin/apt-get*, /usr/sbin/pm-suspend, /home/thiago/bin/restart-sysctl"

# Remove permission line
sudo cat "$sudoers_file" | grep -v "$perm_prefix" | sudo tee -a "$sudoers_file" > /dev/null

# Insert the most updated one again
echo "$perms" | sudo tee -a "$sudoers_file" > /dev/null
