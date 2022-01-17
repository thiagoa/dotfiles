#!/bin/bash

LINUXBREW=${LINUXBREW:-true}

sudo apt install curl

echo "Installing terminal deb packages"

# libnotify-bin -> notify-send command
# libwxbase3.0-0v5 and libwxgtk3.0-gtk3-0v5 -> Veracrypt deps
sudo apt install \
     silversearcher-ag \
     redis \
     nginx \
     rlwrap \
     zsh \
     tmux \
     python3-pip \
     neovim \
     awscli \
     tree \
     git

# Ruby dependencies

sudo apt install \
     libsecret-1-dev \
     libssl-dev \
     libreadline-dev \
     libxslt-dev \
     libxml2-dev \
     libpq-dev

# Dependencies to compile emacs

echo "Installing Emacs dependencies. If this fails, uncomment the debian deb-src repository in /etc/apt/sources.list"
echo "Trying to do that automatically..."

apt_sources_file=/etc/apt/sources.list
deb_src_pattern='deb-src.+universe'
uncommented_deb_src=`egrep "^$deb_src_pattern" $apt_sources_file`

if [[ -z "$uncommented_deb_src" ]]; then
  commented_deb_src=`egrep "^# *${deb_src_pattern}" $apt_sources_file | head -1 | tr -d "\n"`

  if [[ -n "$commented_deb_src" ]]; then
    sudo sed -i "\;$commented_deb_src;s;^# *;;g" $apt_sources_file
    sudo apt update
  fi
fi

sudo apt install libgccjit0 libgccjit-10-dev

sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa \
        && sudo apt-get update -y \
        && sudo apt-get install -y \
                gcc-10 \
                libgccjit0 \
                libgccjit-10-dev \
                gcc-10 \
                g++-10 \
                libjansson4 \
                libjansson-dev \
                build-essential \
                libgtk-3-dev \
                libgnutls28-dev \
                libtiff5-dev \
                libgif-dev \
                libjpeg-dev \
                libpng-dev \
                libxpm-dev \
                libncurses-dev \
                texinfo

sudo apt-get build-dep -y emacs

# Linuxbrew

if [[ "$LINUXBREW" == "true" ]] && [[ ! -d /home/linuxbrew ]]; then
  echo "Installing linuxbrew..."

  if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
    echo "Failed to install Linuxbrew. Are you on arm64? Try running LINUXBREW=false ~/.dotfiles/setup.sh"
  fi

  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# WSL systemctl hack
# User systemctl services are located in ~/.config/systemd/user. That's where
# linuxbrew installs them. After installing this hack, you can install services
# with "brew service start ..." as normal
if uname -r | grep microsoft > /dev/null; then
  systemctl_file=/usr/local/bin/systemctl

  if [[ ! -f "$systemctl_file" ]]; then
    sudo wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py -O $systemctl_file
    sudo chmod +x $systemctl_file
  fi
fi
