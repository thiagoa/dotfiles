autoload -U compinit && compinit
autoload bashcompinit && bashcompinit

compdef g=git

zstyle ':completion:*' menu select=2
zstyle ':completion:history-words:*' list no
zstyle ':completion:history-words:*' menu yes
zstyle ':completion:history-words:*' remove-all-dups yes

setopt no_hist_verify NO_BEEP
setopt rmstarsilent

[[ $EMACS = t ]] && unsetopt zle
[[ $EMACS != t ]] && prompt nicoulaj
[[ -n "$EMACS" ]] && prompt cloud
