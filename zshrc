##############################################
# This file is sourced in interactive shells #
##############################################

source $HOME/.dotfiles/config/aliases.sh
source $HOME/.dotfiles/config/zprezto.sh
source $HOME/.dotfiles/config/zshconfig.sh
source $HOME/.dotfiles/config/zshbindkeys.sh
source $HOME/.dotfiles/config/zshaliases.sh
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

[[ -f $HOME/.secrets  ]] && source $HOME/.secrets
[[ -x $(which direnv) ]] && eval "$(direnv hook zsh)"
