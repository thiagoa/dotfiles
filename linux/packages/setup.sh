#!/bin/bash

dir="$(cd "$(dirname "$0")" && pwd)"

cd $dir

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

  file=$(basename $url)
  cache_path="$dir/.${name}_cache"
  cache_contents=$(cat $cache_path 2> /dev/null)
  is_installed=$(dpkg-query -W $name 2> /dev/null)

  trap "/bin/rm -f $dir/$file" EXIT

  if [[ -z "$is_installed" ]] || [[ "$cache_contents" != "$file" ]]; then
    echo $url | wget -qi -
    sudo dpkg -i "./$file" > /dev/null
    echo $file > $cache_path
    rm -f $file
  fi
done

echo 'Installing xkeysnail hack...'

cd $dir/dummy
make > /dev/null
make install > /dev/null

if [[ ! -d $HOME/bin/datagrip ]]; then
  file="datagrip-2020.1.4.tar.gz"
  echo "Installing datagrip..."

  wget -q https://download.jetbrains.com/datagrip/$file
  mkdir $HOME/bin/datagrip
  tar zvfx ./$file -C $HOME/bin/datagrip > /dev/null 2>&1
  rm -rf ./$file
fi

echo 'Reminder: Have you installed warsaw yet?'

# Configure redis and make it work on Ubuntu 20.04 (upgraded from
# 19.10)
sudo mkdir -p /var/log/redis
sudo chown -R redis:redis /var/log/redis
sudo chmod -R u+rwX,g+rwX,u+rx /var/log/redis
sudo chmod +r /etc/redis/redis.conf
