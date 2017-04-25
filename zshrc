# This file is sourced in interactive shells

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source $HOME/bin/z.sh
source $HOME/.asdf/completions/asdf.bash
source $HOME/.dotfiles/config/zshlocal.sh
source $HOME/.dotfiles/config/zshbindkeys.sh
source $HOME/.dotfiles/config/zshsetopts.sh

# Source aliases again, even though they are already sourced by zshenv for
# non-interactive shells. I want my aliases to prevail over zprezto's utility
# module.
source $HOME/.dotfiles/config/aliases.sh

if [[ -f $HOME/.secrets ]]; then
    source $HOME/.secrets
fi

if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export PATH=$PATH:~/Code/go/bin:~/bin
