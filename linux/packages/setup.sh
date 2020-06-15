#!/bin/bash

declare -a packages
packages=(crow-translate/crow-translate kamranahmedse/pennywise)

for path in "${packages[@]}"; do
  name=`basename $path`
  echo "Installing or updating $name..."

  url=`curl -s https://api.github.com/repos/$path/releases/latest \
  | grep "browser_download_url.*deb" \
  | grep amd64 \
  | cut -d : -f 2,3 \
  | tr -d \"`

  file=`basename $url`

  echo $url | wget -qi -
  sudo dpkg -i ./$file > /dev/null
  rm -f $file
done

echo 'Reminder: Have you installed warsaw yet?'
