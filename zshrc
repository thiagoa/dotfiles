if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source $HOME/bin/z.sh
source $HOME/.shellfunctions.sh
source $HOME/.aliases.sh
source $HOME/.zshlocal.sh
source $HOME/.zshbindkeys.sh
source $HOME/.zshsetopts.sh

if [ -f $HOME/.secrets ]; then
    source $HOME/.secrets
fi

if [ -f /usr/local/Cellar/z/1.9/etc/profile.d/z.sh ]; then
    source /usr/local/Cellar/z/1.9/etc/profile.d/z.sh
fi

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export PATH="$HOME/.rbenv/bin:$PATH:$HOME/bin/go/bin"

eval "$(rbenv init -)"
