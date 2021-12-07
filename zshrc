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

if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

asdf_file="$(brew --prefix asdf)/libexec/asdf.sh"

if [[ -f $asfd_file ]]; then
  source $asdf_file
fi

if [[ -f $HOME/.asdf/asdf.sh ]]; then
  source $HOME/.asdf/asdf.sh
elif [[ -x $(which brew) ]]; then
  asdf_config_path=$(brew --prefix asdf)/libexec/asdf.sh

  if [[ -f $asdf_config_path ]]; then
    source $asdf_config_path
  fi
fi

if [[ -f /opt/homebrew/etc/bash_completion.d ]]; then
  source /opt/homebrew/etc/bash_completion.d
elif [[ -f $HOME/.asdf/completions/asdf.bash ]]; then
  source $HOME/.asdf/completions/asdf.bash
fi

[[ -f $HOME/bin/vendor/z/z.sh ]] && source $HOME/bin/vendor/z/z.sh

if [[ -f $HOME/bin/functions.sh  ]]; then
  source $HOME/bin/functions.sh
fi

if [[ -f $HOME/.dir_colors/dircolors ]]; then
  eval `dircolors /home/thiago/.dir_colors/dircolors`
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey '^X^F' fzf-file-widget
bindkey '^T' transpose-chars
