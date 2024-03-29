alias b="bundle exec"
alias ec='/usr/bin/env emacsclient -n -a "nvim" $*'

if alias o > /dev/null; then
  unalias o
fi

if alias g > /dev/null; then
  unalias g
fi

function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

function r {
  cd `git rev-parse --show-toplevel`
}

alias myip="curl eth0.me"

function srcl {
  echo $1
  src-hilite-lesspipe.sh $1 | less -R
}

function src {
  echo $1
  src-hilite-lesspipe.sh $1
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
alias ag="ag --path-to-ignore ~/.agignore"

# Heroku: deploy to main on remote
function hdep() {
  local remote="${1:-staging}"
  local current_branch="$(git rev-parse --abbrev-ref HEAD)"

  git push -f $remote ${current_branch}:main
}

if [[ "$(uname -s)" == "Linux" ]]; then
  function apt-purge {
    sudo apt purge `dpkg --list | grep '^rc' | awk '{ print $2; }'`
  }

  services="mysql redis-server nginx"

  alias ls="ls -GF --color"
  alias activate-connection="nmcli con up id"
  alias deactivate-connection="nmcli con down"
  alias kill-vpn="sudo pkill openvpn"
  alias xclip="xclip -selection c"
  alias open="xdg-open"
  alias start-dev-services="sudo systemctl start ${services}"
  alias stop-dev-services="sudo systemctl stop ${services}"
  alias restart-dev-services="sudo systemctl restart ${services}"
  alias view-bytes-config="cat /proc/sys/vm/dirty_bytes /proc/sys/vm/dirty_background_bytes"
  alias odf="open-desktop-file"
  alias odd="open-desktop-directory"
  alias i="sudo apt install"
  alias a="sudo apt"
fi
