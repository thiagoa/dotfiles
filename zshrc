# This file is sourced in interactive shells

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source $HOME/bin/z.sh
source $HOME/.functions.sh
source $HOME/.aliases.sh
source $HOME/.zshlocal.sh
source $HOME/.zshbindkeys.sh
source $HOME/.zshsetopts.sh

if [[ -f $HOME/.secrets ]]; then
    source $HOME/.secrets
fi

if [[ -f /usr/local/Cellar/z/1.9/etc/profile.d/z.sh ]]; then
    source /usr/local/Cellar/z/1.9/etc/profile.d/z.sh
fi

if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

export PATH=$PATH:~/Code/go/bin:~/bin
