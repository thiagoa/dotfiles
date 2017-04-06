if [ -n "$INSIDE_EMACS" ]; then
   export TERM=xterm-256color
fi

export BUNDLER_EDITOR=vim
export EDITOR=vim
export VISUAL=vim
export GOPATH=$HOME/Code/go
export WORKON_HOME=$HOME/.virtualenvs
export ELASTIC_PORT=9200

if [ "$(uname)" = "Darwin" ]; then
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    export PGDATA=/usr/local/var/postgres
fi
