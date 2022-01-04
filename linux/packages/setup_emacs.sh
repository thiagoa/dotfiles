#!/bin/bash
# https://www.masteringemacs.org/article/speed-up-emacs-libjansson-native-elisp-compilation
dir="$HOME/Code/c/emacs"

if [[ ! -d "$dir" ]] || [[ "$1" == "--force" ]]; then
  if [[ -d "$dir" ]]; then
    rm -rf $dir
  fi

  git clone git://git.sv.gnu.org/emacs.git $dir

  cd $dir
  export CC="gcc-10"
  export JOBS=4

  if [[ -f autogen.sh ]]; then
     ./autogen.sh
  fi

  ./configure --with-native-compilation --with-mailutils --with-json --with-pgtk
  make -j ${JOBS} && sudo make install
fi
