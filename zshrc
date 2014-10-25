# Load zprezto (lightweight SSH repo)
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source ~/.zlogin

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

# Path to install GO packages
export GOPATH=~/Code/go

# less for source code (requires source-highlight package)
srchighlight() {
    echo $1
    src-hilite-lesspipe.sh $1 | less -R
}
alias src=srchighlight

alias sudo="sudo -e"

# RVM config
PATH=~/Scripts:/usr/local/bin:$HOME/.rvm/bin:$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Better ZSH compatibility with Emacs
[[ $EMACS = t ]] && unsetopt zle

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/thiago/.gvm/bin/gvm-init.sh" ]] && source "/Users/thiago/.gvm/bin/gvm-init.sh"
