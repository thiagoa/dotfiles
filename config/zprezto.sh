zstyle ':prezto:module:utility:ls' color 'yes'
zstyle ':prezto:module:autosuggestions' color 'yes'
zstyle ':prezto:module:history-substring-search' color 'yes'
zstyle ':prezto:module:history-substring-search:color' found 'fg=red,bold'

zstyle ':prezto:load' pmodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'utility' \
  'fasd' \
  'completion' \
  'syntax-highlighting' \
  'history-substring-search' \
  'prompt' \
  'git' \
  $([[ -z "$EMACS" ]] && echo 'autosuggestions')

source $HOME/.zprezto/init.zsh
