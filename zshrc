# Load zprezto (lightweight SSH repo)
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Do not expand history abbreviations by default (unless you use tab)
setopt no_hist_verify

# Better ZSH compatibility with Emacs
[[ $EMACS = t ]] && unsetopt zle

# Mantain a jumplist (use the z command)
source /usr/local/Cellar/z/1.8/etc/profile.d/z.sh

# Include my custom aliases
source ~/.aliases.sh

# Very nice and minimal Peepcode theme
prompt peepcode
