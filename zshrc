#!/usr/bin/env zsh

##############################################
# This file is sourced in interactive shells #
##############################################

source $HOME/.dotfiles/config/zprezto.sh
source $HOME/.dotfiles/config/zprezto_overrides.sh
source $HOME/.dotfiles/config/aliases.sh
source $HOME/.dotfiles/config/functions.sh
source $HOME/.dotfiles/config/zshconfig.sh
source $HOME/.dotfiles/config/zshbindkeys.sh
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

[[ -f $HOME/bin/vendor/z/z.sh ]] && source $HOME/bin/vendor/z/z.sh

if [[ -f $HOME/bin/functions.sh  ]]; then
  source $HOME/bin/functions.sh
fi

if [[ -f $HOME/.dir_colors/dircolors ]]; then
  eval `dircolors /home/thiago/.dir_colors/dircolors`
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey '^X^T' fzf-file-widget
bindkey '^T' transpose-chars
