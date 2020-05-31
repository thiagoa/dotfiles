#!/bin/bash

dir="$(cd "$(dirname "$0")" && pwd)"

dest="/etc/default/veracrypt"

sudo cp $dir/config $dest
sudo chmod 644 $dest
