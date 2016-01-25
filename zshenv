if [ -n "$INSIDE_EMACS" ]; then
   export TERM=xterm-256color
fi

export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export EDITOR=vim
export GOPATH=~/Code/go
export PATH=./bin:/usr/local/bin:$PATH:$HOME/bin:~/.composer/vendor/bin:/usr/local/sbin
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export PGDATA=/usr/local/var/postgres

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

if [ -f ~/.secrets ]; then
    source ~/.secrets
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-atelierlakeside.light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
