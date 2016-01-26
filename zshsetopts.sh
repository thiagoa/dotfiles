autoload bashcompinit
bashcompinit

zstyle ':completion:history-words:*' list no 
zstyle ':completion:history-words:*' menu yes
zstyle ':completion:history-words:*' remove-all-dups yes

setopt no_hist_verify
setopt NO_BEEP
[[ $EMACS = t ]] && unsetopt zle

compdef g=git
