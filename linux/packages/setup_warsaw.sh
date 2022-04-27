#!/usr/bin/env bash

wget -q 'https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb' -O package.deb
sudo dpkg -i ./package.deb
rm -f ./package.deb
