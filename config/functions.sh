g() {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status
    fi
}

after-first-word() {
  zle beginning-of-line
  zle forward-word
}
zle -N after-first-word
