function join-pane {
  tmux join-pane -s $1
}

function send-pane {
  tmux join-pane -t $1
}

function swap-pane {
  if [[ ! -z "$1" ]]; then
    command="-t $1"
  else
    command="-D"
  fi

  tmux swap-pane $command
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

function get-github-release-link {
  local repo=$1
  local pattern=$2

  curl -s "https://api.github.com/repos/$repo/releases/latest" |
    grep "browser_download_url" |
    grep "$pattern" |
    cut -d : -f 2,3 |
    tr -d \"
}
