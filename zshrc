if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source ~/.shellfunctions.sh
source ~/.aliases.sh
source ~/.zshlocal.sh
source ~/.zshbindkeys.sh
source ~/.zshsetopts.sh

if [ -f ~/.secrets ]; then
    source ~/.secrets
fi

if [ -f /usr/local/Cellar/z/1.9/etc/profile.d/z.sh ]; then
    source /usr/local/Cellar/z/1.9/etc/profile.d/z.sh
fi

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

eval "$(rbenv init -)"
