#!/usr/bin/env zsh

##############################################
# This file is sourced in interactive shells #
##############################################

source $HOME/.dotfiles/config/zprezto.sh
source $HOME/.dotfiles/config/zprezto_overrides.sh
source $HOME/.dotfiles/config/aliases.sh
source $HOME/.dotfiles/config/zshconfig.sh
source $HOME/.dotfiles/config/zshbindkeys.sh
source $HOME/.dotfiles/config/zshaliases.sh
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

[[ -f ~/bin/z.sh ]] && source ~/bin/z.sh

if [[ -f $HOME/bin/functions.sh  ]]; then
  source $HOME/bin/functions.sh
fi
