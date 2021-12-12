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

if [[ "$(uname)" == "Darwin" ]]; then
    sys-copy-to-clipboard() {
        pbcopy
    }

    sys-paste-from-clipboard() {
        pbpaste
    }
else
    sys-copy-to-clipboard() {
        xclip -selection clipboard -i
    }

    sys-paste-from-clipboard() {
        xclip -selection clipboard -o
    }
fi

copy-to-clipboard() {
    [[ "$REGION_ACTIVE" -ne 0 ]] && zle copy-region-as-kill
    print -rn -- $CUTBUFFER | sys-copy-to-clipboard
}

kill-region-to-clipboard() {
    [[ "$REGION_ACTIVE" -ne 0 ]] && zle kill-region
    print -rn -- $CUTBUFFER | sys-copy-to-clipboard
}

kill-line-to-clipboard() {
    zle kill-line
    print -rn -- $CUTBUFFER | sys-copy-to-clipboard
}

zle -N copy-to-clipboard
zle -N kill-region-to-clipboard

bindkey "^[w" copy-to-clipboard
bindkey "^w" kill-region-to-clipboard

zle -N kill-line-to-clipboard
bindkey "^k" kill-line-to-clipboard

paste-clipboard() {
    killring=("$CUTBUFFER" "${(@)killring[1,-2]}")
    CUTBUFFER=$(sys-paste-from-clipboard)
    zle yank
}

zle -N paste-clipboard
bindkey "^y" paste-clipboard
