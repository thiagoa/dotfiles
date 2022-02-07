#!/usr/bin/env zsh

##################################################################
# This file is sourced in interactive and non-interactive shells #
##################################################################

function add_to_path {
    export PATH=$PATH:"${1}"
}

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

add_to_path ~/bin

function maybe_add_to_path {
    local base=$1
    local dirname=$2
    local mindepth=${3:-1}
    local dir=$(find "${base}" \
                     -maxdepth 2 \
                     -mindepth $mindepth \
                     -name "${dirname}" 2> /dev/null \
                    | tail -1)

    if [[ -d $dir ]]; then
        add_to_path "${dir}"
    fi
}

maybe_add_to_path $HOME/Library/Python bin 2

if [[ -d /Applications ]]; then
  maybe_add_to_path "$(find /Applications \
                            -maxdepth 1 \
                            -name '*Racket v*' \
                            | sort \
                            | tail -1)" \
                    bin
fi

if [[ $(uname) == 'Darwin' ]]; then
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

export WEB_TIMEOUT=66666666666666666
export UNICORN_TIMEOUT=$WEB_TIMEOUT
export VISUAL=${VISUAL:-nvim}
export BUNDLER_EDITOR=$VISUAL
export EDITOR=$VISUAL
export LESS='-F -g -i -M -R -S -w -X -z-4'
export DIRENV_LOG_FORMAT=
export RIPPER_TAGS_EMACS=true
export RIPPER_TAGS_EXTRA_FLAGS=q
export HISTFILE # Make shell history available from within Emacs
export QT_QPA_PLATFORMTHEME=gtk2
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

if [[ $0 = *zsh ]]; then
  if (( $#commands[(i)lesspipe(|.sh)] )); then
    export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
  fi
fi

source $HOME/.dotfiles/config/asdf.sh

if [[ ! -o interactive ]]; then
    if [[ -f $HOME/.asdf/asdf.sh ]]; then
      source $HOME/.asdf/asdf.sh
    elif [[ -f /opt/homebrew/lib/asdf.sh ]]; then
      source /opt/homebrew/lib/asdf.sh
    fi
fi

[[ -f $HOME/.secrets ]] && source $HOME/.secrets
