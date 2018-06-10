#!/usr/bin/env zsh

##################################################################
# This file is sourced in interactive and non-interactive shells #
##################################################################

export PATH=$PATH:~/bin

function maybe_add_pip_dir {
    local dir=$HOME/Library/Python
    local dir=$(find $dir -maxdepth 2 -mindepth 2 -name bin 2> /dev/null | tail -1)

    if [[ -d $dir ]]; then
        export PATH=$PATH:$dir
    fi
}

maybe_add_pip_dir

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
