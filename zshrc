# This file is sourced in interactive shells
source $HOME/.dotfiles/utilities/detect_path_overwrite.sh
source $HOME/.dotfiles/config/zpreztomodules.sh

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Interactive shell configuration: prompts, keybindings, completion opts, etc.
source $HOME/.dotfiles/config/zshlocal.sh
source $HOME/.dotfiles/config/zshbindkeys.sh
source $HOME/.dotfiles/config/zshsetopts.sh

# Quickly jump to directories
source $HOME/bin/z.sh

# Source "aliases" again, even though they are already sourced by zshenv for
# non-interactive shells. I want my aliases to prevail over zprezto's "utility"
# module.
source $HOME/.dotfiles/config/aliases.sh

# Custom completions
source $HOME/.asdf/completions/asdf.bash

if [[ -f $HOME/.secrets ]]; then
    source $HOME/.secrets
fi

if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# This same line is also available in .zshenv for non-interactive shells, but
# is also needed here because otherwise asdf doesn't get PATH priority.
source $HOME/.asdf/asdf.sh
