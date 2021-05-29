#!/bin/bash
# https://www.masteringemacs.org/article/speed-up-emacs-libjansson-native-elisp-compilation
dir="$HOME/Code/c/emacs"

if [[ ! -d "$dir" ]]; then
  git clone https://git.savannah.gnu.org/git/emacs.git $dir
  cd $dir
  export CC="gcc-10"
  export JOBS=4

  ./autogen.sh && ./configure --with-native-compilation --with-mailutils
  make -j ${JOBS} && make install
fi
