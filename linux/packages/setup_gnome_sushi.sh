#!/bin/bash
# https://www.masteringemacs.org/article/speed-up-emacs-libjansson-native-elisp-compilation
dir="$HOME/Code/linux/sushi"
curdir="$(pwd)"

if [[ ! -d "$dir" ]] || [[ -n "$FORCE" ]]; then
  if [[ -d "$dir" ]]; then
    rm -rf "$dir"
  fi

  git clone https://gitlab.gnome.org/GNOME/sushi.git $dir
  cd $dir && meson builddir && cd builddir
  sudo meson install
  cd $curdir
fi
