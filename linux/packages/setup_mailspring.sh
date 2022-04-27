#!/usr/bin/env bash

wget -q 'https://updates.getmailspring.com/download?platform=linuxDeb' -O mailspring.deb
sudo dpkg -i ./mailspring.deb
rm -f ./mailspring.deb
