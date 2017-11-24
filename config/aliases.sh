# Source this file in bash, ZSH or any sh compatible shell

alias ls="ls -F -G"
alias b="bundle exec"
alias vi="nvim"
alias vim="nvim"
alias myip="curl eth0.me"
alias pg="postgres -D /usr/local/var/postgres"
alias treeless="tree -C | less -R"
alias src=srchighlight
alias gpg="gpg2"
alias ec='exec /usr/bin/env emacsclient -c -a "" $*'

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if [ -x "$(command -v nvr)" ]; then
        alias nvim="nvr"
        alias vim="nvr"
        alias vi="nvr"
    else
        alias vim="echo You can not nest vim sessions. Use nvr [-l|-o|-O|-p]"
        alias nvim="vim"
        alias vi="vim"
    fi
fi
