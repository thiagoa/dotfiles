#!/usr/bin/env bash

source $HOME/.dotfiles/config/functions.sh

echo "Setting up Trello..."

if [[ "$1" == "--force" ]]; then
  force="true"
fi

if [[ ! -d "$installation_dir" ]] || [[ -n "$force" ]]; then
  installation_dir=$HOME/bin/vendor/trello

  if [[ -n "$force" ]]; then
    rm -rf $installation_dir
  fi

  download_link=`get-github-release-link Racle/trello-desktop "linux.*zip"`
  file=`basename $download_link`
  wget -q $download_link -O $file
  unzip -q $file -d $installation_dir
  rm -f ./$file
fi
