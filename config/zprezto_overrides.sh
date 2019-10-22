# WORDCHARS is set via zprezto's "editor" module, otherwise should be
# set in zshenv
export WORDCHARS=$(echo $WORDCHARS | tr -d "._-")
