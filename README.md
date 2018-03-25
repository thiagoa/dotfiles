# Thiago's minimal dotfiles

## Installation

    $ git clone https://github.com/thiagoa/dotfiles.git ~/.dotfiles
    $ ~/.dotfiles/setup.sh

The git repository must be cloned in `~/.dotfiles`.

## What does setup.sh do?

- Installs zsh and zprezto (lightweight zsh setup)
- Sets zsh as the default shell
- Installs asdf version manager
- Generates a SSH key if none
- Installs my `~/bin` folder
- Symlinks my dotfiles. Any file in the root folder gets symlinked as a dotfile
  in your home directory.
- Installs my vim configuration
- Installs base16. I have settled down on this theme

This is an idempotent script, run it as many times as you want.

For more information see `setup.sh`.
