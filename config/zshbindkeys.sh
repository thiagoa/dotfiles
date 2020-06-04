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
bindkey '^ ' set-mark-command

copy-to-xclip() {
    [[ "$REGION_ACTIVE" -ne 0 ]] && zle copy-region-as-kill
    print -rn -- $CUTBUFFER | xclip -selection clipboard -i
}

kill-region-to-xclip() {
    [[ "$REGION_ACTIVE" -ne 0 ]] && zle kill-region
    print -rn -- $CUTBUFFER | xclip -selection clipboard -i
}

kill-line-to-xclip() {
    zle kill-line
    print -rn -- $CUTBUFFER | xclip -selection clipboard -i
}

zle -N copy-to-xclip
zle -N kill-region-to-xclip

bindkey "^[w" copy-to-xclip
bindkey "^w" kill-region-to-xclip

zle -N kill-line-to-xclip
bindkey "^k" kill-line-to-xclip

paste-xclip() {
    killring=("$CUTBUFFER" "${(@)killring[1,-2]}")
    CUTBUFFER=$(xclip -selection clipboard -o)
    zle yank
}

zle -N paste-xclip
bindkey "^y" paste-xclip
