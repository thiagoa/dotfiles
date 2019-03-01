#!/usr/bin/env zsh

##################################################################
# This file is sourced in interactive and non-interactive shells #
##################################################################

function add_to_path {
    export PATH=$PATH:"${1}"
}

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
maybe_add_to_path "$(find /Applications \
                          -maxdepth 1 \
                          -name '*Racket v*' \
                          | sort \
                          | tail -1)" \
                  bin \

if [[ $(uname) == 'Darwin' ]]; then
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

export VISUAL=${VISUAL:-nvim}
export BUNDLER_EDITOR=$VISUAL
export EDITOR=$VISUAL
export LESS='-F -g -i -M -R -S -w -X -z-4'
export DIRENV_LOG_FORMAT=

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

if [[ ! -o interactive ]]; then
    source $HOME/.asdf/asdf.sh
fi

[[ -f $HOME/.secrets ]] && source $HOME/.secrets
