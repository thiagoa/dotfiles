alias b="bundle exec"
alias ec='/usr/bin/env emacsclient -n -a "nvim" $*'
alias ls="ls -GF --color"

if alias o > /dev/null; then
  unalias o
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

if [[ "$(uname -s)" == "Linux" ]]; then
  function apt-purge {
    sudo apt purge `dpkg --list | grep '^rc' | awk '{ print $2; }'`
  }

  alias activate-connection="nmcli con up id"
  alias deactivate-connection="nmcli con down"
  alias kill-vpn="sudo pkill openvpn"
  alias xclip="xclip -selection c"
  alias open="xdg-open"
  alias start-dev-services="sudo systemctl start mysql redis-server nginx"
fi
