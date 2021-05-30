#!/bin/bash

echo "Installing deb packages"

sudo add-apt-repository ppa:agornostal/ulauncher -y > /dev/null 2> /dev/null
sudo apt update > /dev/null 2> /dev/null

# libnotify-bin -> notify-send command
# libwxbase3.0-0v5 and libwxgtk3.0-gtk3-0v5 -> Veracrypt deps
sudo apt install \
     xdotool \
     silversearcher-ag \
     timeshift \
     deja-dup \
     redis \
     nginx \
     grub2-common \
     grub-efi \
     grub-customizer \
     guake \
     cheese \
     neovim \
     rlwrap \
     lm-sensors \
     zsh \
     gnome-tweaks \
     ulauncher \
     qt5-style-plugins \
     zeal \
     tmux \
     flameshot \
     network-manager-openvpn \
     network-manager-openvpn-gnome \
     libnotify-bin \
     libwxbase3.0-0v5 \
     libwxgtk3.0-gtk3-0v5 \
     awscli \
     bluez-tools \
     autokey-gtk \
     xbindkeys \
     python3-pip \
     solaar \
     libjansson4 \
     libjansson-dev \
     git \
     texinfo \
     dconf-editor \
     xvkbd \
     seahorse-nautilus \
     pm-utils \
     autorandr

# Standalone app dependencies (Crow translate, etc)

sudo apt install \
     gconf-service \
     gconf-service-backend \
     gconf2 \
     gconf2-common \
     libappindicator1 \
     libdbusmenu-gtk4 \
     libgconf-2-4 \
     liblept5 \
     libqt5multimedia5 \
     libtesseract4

# Gnome sushi dependencies

sudo apt install \
     meson \
     libevince-dev \
     gir1.2-gstreamer-1.0 \
     librust-gstreamer-audio-sys-dev \
     librust-gstreamer-audio-sys-dev \
     libgtksourceview-4-dev \
     libmusicbrainz5-dev \
     libwebkit2gtk-4.0-dev \
     libgirepository1.0-dev \
     ninja-build


# Ruby dependencies

sudo apt install \
     libsecret-1-dev \
     libssl-dev \
     libreadline-dev

# Docker

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Indicator sticky notes

sudo add-apt-repository ppa:umang/indicator-stickynotes -y && sudo apt-get update && sudo apt-get install indicator-stickynotes -y

# Dependencies to compile emacs

sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa \
        && sudo apt-get update -y \
        && sudo apt-get install -y gcc-10 libgccjit0 libgccjit-10-dev

sudo apt-get build-dep -y emacs

# TODO improve this mess
default_release="$(lsb_release -cs)"
default_release=focal

echo "WARNING! Using older focal repository for docker!"

# WARNING: If this fails for some reason, the docker repo is not available for
# the current Ubuntu version so replace lsb_release -cs with Ubuntu version's
# codename
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $default_release \
   stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker ${USER}

if [[ -x "$(which pip3)" ]]; then
  # TODO: Decide whether to install brotab from pip or from source
  # See https://github.com/thiagoa/brotab/blob/master/DEVELOPMENT.md
  for package in nativemessaging pygithub brotab; do
    if ! pip3 show "$package" > /dev/null 2>&1; then
      echo "Installing $package python package"
      pip3 install $package
    fi
  done
else
  echo "WARNING: pip3 not installed! Install it and run setup again" 1>&2
fi

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
