alias b="bundle exec"
alias ec='/usr/bin/env emacsclient -n -a "nvim" $*'

function g {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status
    fi
}

if command -v compdef > /dev/null; then
    compdef g=git
fi

function r {
    cd `git rev-parse --show-toplevel`
}

alias myip="curl eth0.me"

function src {
    echo $1
    src-hilite-lesspipe.sh $1 | less -R
}

alias treeless="tree -C | less -R"
alias vim="command nvim"

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if command -v nvr > /dev/null; then
        alias vim="nvr"
    else
        alias vim="echo You can not nest vim sessions. Use nvr [-l|-o|-O|-p]"
    fi
fi

alias vi="vim"
alias nvim="vim"
alias z="fasd_cd -d"
