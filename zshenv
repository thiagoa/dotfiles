if [ -n "$INSIDE_EMACS" ]; then
   export TERM=xterm-256color
fi

export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8
export BUNDLER_EDITOR=vim
export EDITOR=vim
export GOPATH=$HOME/Code/go
export WORKON_HOME=$HOME/.virtualenvs

if [ "$(uname)" = "Darwin" ]; then
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    export PGDATA=/usr/local/var/postgres
fi
