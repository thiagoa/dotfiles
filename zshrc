# Load zprezto (lightweight SSH repo)
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Include my custom aliases
source ~/.aliases.sh

# Very nice and minimal Peepcode theme
prompt peepcode

# Do not expand history abbreviations by default (unless you use tab)
setopt no_hist_verify

# Mantain a jumplist (use the z command)
source /usr/local/Cellar/z/1.8/etc/profile.d/z.sh

# Homebrew cask for OS X installations
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Default editor (use edit command, many other things use this var)
export EDITOR=vim

# less for source code (requires source-highlight package)
srchighlight() {
    echo $1
    src-hilite-lesspipe.sh $1 | less -R
}
alias src=srchighlight

# RVM config
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Make ZSH play a bit more nicer with Emacs
[[ $EMACS = t ]] && unsetopt zle
