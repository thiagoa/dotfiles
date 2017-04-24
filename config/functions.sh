function g {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status
    fi
}

function join-pane {
    tmux join-pane -s $1
}

function send-pane {
    tmux join-pane -t $1
}

function swap-pane {
    tmux swap-pane -t $1
}

function swap-window {
    tmux swap-window -t $1
}

function break-pane {
    tmux break-pane -d
}

function resize-pane {
    tmux resize-pane -${1:u} $2
}

# Custom command to place cursor after first word
function after-first-word {
    zle beginning-of-line
    zle forward-word
}
zle -N after-first-word
