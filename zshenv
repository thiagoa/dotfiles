# This file is always sourced

if [ -n "$INSIDE_EMACS" ]; then
   export TERM=xterm-256color
fi

export PATH=$PATH:~/bin:~/Library/Python/3.6/bin

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr --remote-wait -o"
else
    export VISUAL=nvim
fi

export BUNDLER_EDITOR=$VISUAL
export EDITOR=$VISUAL
export WORKON_HOME=$HOME/.virtualenvs
export ELASTIC_PORT=9200
export STACK_PATH=$HOME/Code/stack
export LESS='-F -g -i -M -R -S -w -X -z-4'
export DIRENV_LOG_FORMAT=

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
    export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"
    export PGDATA="/usr/local/var/postgres"
fi

if [[ ! -o interactive ]]; then
    source $HOME/.asdf/asdf.sh
fi

# This configuration needs to be always available,
# even in non-interactive shells (e.g., vim's "bang" command)
source $HOME/.dotfiles/config/functions.sh
