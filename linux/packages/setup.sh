#!/bin/bash

echo "Installing deb packages"

sudo add-apt-repository ppa:agornostal/ulauncher -y > /dev/null 2> /dev/null
sudo apt update > /dev/null 2> /dev/null

sudo apt install \
     xdotool \
     geary \
     silversearcher-ag \
     timeshift \
     deja-dup \
     redis \
     nginx \
     grub2-common \
     grub-efi \
     grub-customizer \
     neovim \
     zsh \
     ulauncher \
     rclone \
     autokey-gtk > /dev/null 2> /dev/null

echo "Reminder: Install Emacs from source"
echo "Reminder: Download and install Google Chrome"
echo "Reminder: Download and install Dropbox"
echo "Reminder: Configure rclone for OneDrive"

dir="$(cd "$(dirname "$0")" && pwd)"

cd $dir

declare -a packages
packages=(crow-translate/crow-translate kamranahmedse/pennywise)

for path in "${packages[@]}"; do
  name=$(basename $path)

  echo "Installing or updating $name..."

  url=`curl -s https://api.github.com/repos/$path/releases/latest \
  | grep "browser_download_url.*deb" \
  | grep amd64 \
  | cut -d : -f 2,3 \
  | tr -d \"`

  if [[ ! -z "$url" ]]; then
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
  else
    echo "ERROR: Failed to download info for ${name}! Rate limit error?" 1>&2
  fi
done

echo 'Installing xkeysnail hack...'

cd $dir/dummy

make > /dev/null 2> /dev/null
make install > /dev/null 2> /dev/null

cd - > /dev/null

datagrip_dest=$HOME/bin/vendor/datagrip

if [[ ! -d $datagrip_dest ]]; then
  echo "Installing datagrip..."

  file="datagrip-2020.1.4.tar.gz"
  wget -q https://download.jetbrains.com/datagrip/$file
  tmp_folder=$(tar ztvf $file | head -1 | awk '{ print $6 }' | grep -o 'DataGrip-[0-9]\{4\}.[0-9].[0-9]')

  if [[ ! -z "$tmp_folder" ]]; then
    mkdir $datagrip_dest
    tar zvfx ./$file -C $datagrip_dest > /dev/null 2>&1
    mv $datagrip_dest/$tmp_folder/* $datagrip_dest
    rmdir $datagrip_dest/$tmp_folder
  else
    echo 'ERROR: Failed to install datagrip!' 1>&2
  fi

  rm -rf ./$file
fi

echo 'Reminder: Have you installed warsaw yet?'

# Configure redis and make it work on Ubuntu 20.04 (upgraded from
# 19.10)
sudo mkdir -p /var/log/redis
sudo chown -R redis:redis /var/log/redis
sudo chmod -R u+rwX,g+rwX,u+rx /var/log/redis
sudo chmod +r /etc/redis/redis.conf
