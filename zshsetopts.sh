autoload bashcompinit
bashcompinit

autoload -U compinit
compinit

fpath=(~/.dotfiles/custom_completions $fpath)

zstyle ':completion:*' menu select=2
zstyle ':completion:history-words:*' list no 
zstyle ':completion:history-words:*' menu yes
zstyle ':completion:history-words:*' remove-all-dups yes

setopt no_hist_verify
setopt NO_BEEP

[[ $EMACS = t ]] && unsetopt zle

compdef g=git
