if [ -n "$INSIDE_EMACS" ]; then
   export TERM=xterm-256color
fi

export BUNDLER_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim
export WORKON_HOME=$HOME/.virtualenvs
export ELASTIC_PORT=9200
export STACK_PATH=$HOME/Code/stack

if [ "$(uname)" = "Darwin" ]; then
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    export PGDATA=/usr/local/var/postgres
fi
