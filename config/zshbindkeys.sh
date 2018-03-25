function after-first-word {
    zle beginning-of-line
    zle forward-word
}

function fancy-ctrl-z {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N after-first-word
zle -N fancy-ctrl-z

bindkey "^X1" after-first-word
bindkey '^x^k' kill-region
bindkey '^Z' fancy-ctrl-z
bindkey '^]' kill-line
bindkey '^G' backward-delete-char
