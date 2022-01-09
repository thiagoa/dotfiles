#!/usr/bin/env zsh

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  source $HOME/.asdf/asdf.sh
elif [[ -x $(which brew) ]]; then
  asdf_config_path=$(brew --prefix asdf)/libexec/asdf.sh

  if [[ -f $asdf_config_path ]]; then
    source $asdf_config_path
  fi
fi
