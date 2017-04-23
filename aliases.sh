# Source this file in bash, ZSH or any sh compatible shell

alias vi="nvim"
alias vim="nvim"
alias myip="curl eth0.me"
alias pg="postgres -D /usr/local/var/postgres"
alias treeless="tree -C | less -R"

# less for source code (requires source-highlight package)
srchighlight() {
    echo $1
    src-hilite-lesspipe.sh $1 | less -R
}

alias src=srchighlight
alias gpg="gpg2"

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
bindkey '^Z' fancy-ctrl-z

alias -s rb=vim
alias -s erb=vim
alias -s php=vim

alias ec='exec /usr/bin/env emacsclient -c -a "" $*'

alias gc="open -a \"/Applications/Google Chrome.app\" --args --force-renderer-accessibility"

alias b="bundle exec"
