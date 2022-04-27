#!/usr/bin/env bash

wget --content-disposition -q https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
sudo dpkg -i ./1password-latest.deb
rm -f ./1password-latest.deb
