# Load zprezto (lightweight SSH repo)
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Do not expand history abbreviations by default (unless you use tab)
setopt no_hist_verify

# No beeps, please
setopt NO_BEEP

# Better ZSH compatibility with Emacs
[[ $EMACS = t ]] && unsetopt zle

# Mantain a jumplist (use the z command)
source /usr/local/Cellar/z/1.8/etc/profile.d/z.sh

# Search history with the string from beginning up to cursor position
bindkey '^xp' history-beginning-search-backward
bindkey '^xn' history-beginning-search-forward
bindkey '^x^k' kill-region

# Move to where the arguments belong.
after-first-word() {
  zle beginning-of-line
  zle forward-word
}
zle -N after-first-word
bindkey "^X1" after-first-word

# Include my custom aliases
source ~/.aliases.sh

# Nice prompt
prompt nicoulaj

# $1 = type; 0 - both, 1 - tab, 2 - title
# rest = text
setTerminalText () {
    # echo works in bash & zsh
    local mode=$1 ; shift
    echo -ne "\033]$mode;$@\007"
}
stt_both  () { setTerminalText 0 $@; }
stt_tab   () { setTerminalText 1 $@; }
stt_title () { setTerminalText 2 $@; }

# Complete in history with M-/, M-,
zstyle ':completion:history-words:*' list no 
zstyle ':completion:history-words:*' menu yes
zstyle ':completion:history-words:*' remove-all-dups yes
bindkey "\e/" _history-complete-older
bindkey "\e," _history-complete-newer
