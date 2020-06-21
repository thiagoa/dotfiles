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

# Configure redis and make it work on Ubuntu 20.04 (upgraded from
# 19.10)
sudo mkdir -p /var/log/redis
sudo chown -R redis:redis /var/log/redis
sudo chmod -R u+rwX,g+rwX,u+rx /var/log/redis
sudo chmod +r /etc/redis/redis.conf

echo 'Reminder: Have you installed warsaw yet?'
