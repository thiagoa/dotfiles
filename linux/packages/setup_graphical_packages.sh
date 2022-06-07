#!/bin/bash

echo "Installing deb packages"

sudo add-apt-repository ppa:agornostal/ulauncher -y > /dev/null 2> /dev/null
sudo add-apt-repository ppa:solaar-unifying/stable -y > /dev/null 2> /dev/null

sudo apt update > /dev/null 2> /dev/null

# libnotify-bin -> notify-send command
# libwxbase3.0-0v5 and libwxgtk3.0-gtk3-0v5 -> Veracrypt deps
sudo apt install \
     xdotool \
     timeshift \
     deja-dup \
     guake \
     cheese \
     peek \
     ulauncher \
     lm-sensors \
     gnome-tweaks \
     qt5-style-plugins \
     zeal \
     flameshot \
     network-manager-openvpn \
     network-manager-openvpn-gnome \
     libnotify-bin \
     libwxbase3.0-0v5 \
     libwxgtk3.0-gtk3-0v5 \
     bluez-tools \
     autokey-gtk \
     xbindkeys \
     python3-pip \
     solaar \
     libjansson4 \
     libjansson-dev \
     texinfo \
     dconf-editor \
     xvkbd \
     seahorse-nautilus \
     pm-utils \
     autorandr \
     pavucontrol \
     inotify-tools \
     gnome-clocks \
     pdfarranger \
     zathura \
     snapd \
     redshift-gtk \
     eog \
     heif-gdk-pixbuf

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

# Install flatpaks

flatpak install flathub org.gabmus.hydrapaper
flatpak install flathub uk.co.ibboard.cawbird
flatpak install flathub com.discordapp.Discord

# Install snaps (hopefully flatpak will have them soon)

sudo snap install --classic heroku
sudo snap install authy

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
packages=(crow-translate/crow-translate kamranahmedse/pennywise klaussinani/ao)

source $HOME/.dotfiles/config/functions.sh

for path in "${packages[@]}"; do
  name=$(basename $path)

  echo "Installing or updating $name..."

  url=`get-github-release-link $path "amd64.*deb"`

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

# Configure redis and make it work on Ubuntu 20.04 (upgraded from
# 19.10)
sudo mkdir -p /var/log/redis
sudo chown -R redis:redis /var/log/redis
sudo chmod -R u+rwX,g+rwX,u+rx /var/log/redis
sudo chmod +r /etc/redis/redis.conf
