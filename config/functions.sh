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

srchighlight() {
    echo $1
    src-hilite-lesspipe.sh $1 | less -R
}

function after-first-word {
    zle beginning-of-line
    zle forward-word
}
zle -N after-first-word

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
