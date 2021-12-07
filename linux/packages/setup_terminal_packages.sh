#!/bin/bash

echo "Installing terminal deb packages"

if [[ ! -d /home/linuxbrew ]]; then
  echo "Installing linuxbrew..."

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# libnotify-bin -> notify-send command
# libwxbase3.0-0v5 and libwxgtk3.0-gtk3-0v5 -> Veracrypt deps
sudo apt install \
     silversearcher-ag \
     redis \
     nginx \
     rlwrap \
     zsh \
     tmux \
	 neovim \
     awscli \
     git

# Ruby dependencies

sudo apt install \
     libsecret-1-dev \
     libssl-dev \
     libreadline-dev

# Dependencies to compile emacs

echo "Installing Emacs dependencies. If this fails, uncomment the debian deb-src repository in /etc/apt/sources.list"

sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa \
        && sudo apt-get update -y \
        && sudo apt-get install -y gcc-10 libgccjit0 libgccjit-10-dev

sudo apt-get build-dep -y emacs
