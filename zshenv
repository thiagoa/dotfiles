if [ -n "$INSIDE_EMACS" ]; then
   export TERM=xterm-256color
fi

export BUNDLER_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim
export WORKON_HOME=$HOME/.virtualenvs
export ELASTIC_PORT=9200
export STACK_PATH=$HOME/Code/stack
export LESS='-F -g -i -M -R -S -w -X -z-4'

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
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"
    export PGDATA="/usr/local/var/postgres"
fi
