#!/bin/bash

# Color variables
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

# Bash vi mode
set -o vi

# Common commands abbr
alias ls="ls -G"
alias hist="history"
alias so="source"

# Aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gitrm="git ls-files --deleted | xargs git rm"
alias php="/Applications/MAMP/bin/php5.3/bin/php"
alias mysql="/Applications/MAMP/Library/bin/mysql -u root --password=root"
alias mysqldump="/Applications/MAMP/Library/bin/mysqldump -u root --password=root"
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

# SSH servers
alias sshmixr="ssh root@mix.no-ip.biz"
alias sshmix="ssh thiago@mix.no-ip.biz"
alias sshsol="ssh thiago@solcorretora.com.br"
alias sshmixatomi="ssh root@mixatomico.com.br"

alias www="cd ~/Sites"

# Bash completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# Git completion
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

# Term type
export TERM="xterm-color"
