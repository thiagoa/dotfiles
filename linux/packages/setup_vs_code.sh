#!/usr/bin/env bash

wget -q 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O vs_code.deb
sudo dpkg -i ./vs_code.deb
rm -f ./vs_code.deb
