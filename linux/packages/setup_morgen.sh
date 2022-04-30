#!/usr/bin/env bash

wget -q 'https://dl.todesktop.com/210203cqcj00tw1/linux/deb/x64' -O package.deb
sudo dpkg -i ./package.deb
rm -f ./package.deb
