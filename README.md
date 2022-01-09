# Thiago's dotfiles

This was made specifically for me as a live documentation of my tools, and it
assumes a "thiago" user exists.

## Installation

    $ sudo apt install zsh
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
- Installs my Linux configuration on Linux and/or WSL systems
- Installs my Mac configuration on Mac computers
- Many more!

This is an idempotent script, run it as many times as you want.

For more information see `setup.sh`.
