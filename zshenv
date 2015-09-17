if [ -n "$INSIDE_EMACS" ]; then
   export TERM=xterm-256color
fi

export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export EDITOR=vim
export GOPATH=~/Code/go
export PATH=./bin:$PATH:$HOME/Scripts:~/.composer/vendor/bin
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export PGDATA=/usr/local/var/postgres
export JAVA_OPTS="-server -XX:MaxPermSize=512m"
export GRAILS_OPTS="-XX:MaxPermSize=1024m -Xmx1024M -server"

source /usr/local/bin/virtualenvwrapper.sh

if [ -f ~/.secrets ]; then
    source ~/.secrets
fi
