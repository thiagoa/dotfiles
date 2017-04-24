#!/usr/bin/env zsh
#
# Thiago's Dotfiles setup
#
# Idempotent, smart setup tool: Install dotfiles, vim, bin files, asdf, etc.
# Run as many times as you want, it won't mess up anything.

set -eu
setopt EXTENDED_GLOB

INSTALL_DIR="${HOME}/.dotfiles"

if ! $(which git > /dev/null 2>&1); then
    echo "ERROR: Yow, I need git... gimme git!"
    exit 1
fi

if [[ ! -d $INSTALL_DIR ]]; then
    echo "ERROR: Please clone this repository in ~/.dotfiles"
fi

function create_directories {
    echo "Creating $HOME/Code directory...\n"

    if [[ ! -d /bin ]]; then rmdir /bin; fi
    if [[ ! -d $HOME/Code/go ]]; then mkdir -p $HOME/Code/go; fi
}

function install_binfiles  {
    if [[ -d $HOME/bin ]]; then return; fi

    echo "Installing bin directory...\n"

    git clone --quiet https://github.com/thiagoa/bin $HOME/bin
}

function install_asdf {
    if [[ -d $HOME/.asdf ]]; then return; fi

    echo "Installing asdf...\n"

    # Still need to figure out how to get the most up-to-date version...
    git clone --quiet https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.3.0 > /dev/null
}

function generate_ssh_key {
    if [[ -f $HOME/.ssh/id_rsa.pub ]]; then return; fi

    echo "Generating SSH key...\n"

    ssh-keygen -t rsa

    echo "\nYour key has been generated. Now go to Github."
}

function install_zprezto {
    if [[ -d $HOME/.zprezto ]]; then return; fi

    echo "Installing zprezto..."

    git clone --quiet --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" > /dev/null 2>&1

    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
}

function install_dotfiles {
    echo "Installing dotfiles..."

    for file in ${INSTALL_DIR}/^(setup.sh|README.md)(.N:t); do
        if [ -f "$HOME/.$file" ] || [ -h "$HOME/.$file" ]; then
            rm $HOME/.$file
        fi

        ln -s $INSTALL_DIR/$file $HOME/.$file
    done
}

function install_vimfiles {
    if [[ -d $HOME/.vim ]]; then return; fi

    echo "Installing vimfiles...\n"

    git clone --quiet https://github.com/thiagoa/dotvim $HOME/.vim

    $HOME/.vim/setup.sh
}


function install_base16 {
    if [[ -d $HOME/.config/base16-shell ]]; then return; fi

    echo "\nInstalling base16 themes..."

    git clone --quiet https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell

    BASE16_SHELL=$HOME/.config/base16-shell/
    eval "$($BASE16_SHELL/profile_helper.sh)"
}


function check_sudoers {
    echo "\nLet's check if your user is in sudoers...\n"
    

    if ! $(sudo -l 2> /dev/null); then
        echo "\nERROR: Please add your user to sudoers and run this script again"
        exit 1
    fi
}

function set_defaults {
    if ! $(cat /etc/passwd | grep $USER | grep zsh > /dev/null); then
        echo "\nSetting ZSH as default shell..."

        chsh -s $(which zsh)
    fi
}

function set_git_remotes_as_authenticated {
    cd $HOME/.vim && git remote set-url origin git@github.com:thiagoa/dotvim.git
    cd $INSTALL_DIR && git remote set-url origin git@github.com:thiagoa/dotfiles.git
    cd $HOME/bin && git remote set-url origin git@github.com:thiagoa/bin.git
}

function install_tmux_tpm {
    git clone -q https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
}

create_directories
install_binfiles
install_asdf
generate_ssh_key
install_zprezto
install_dotfiles
install_vimfiles
install_base16
install_tmux_tpm
set_defaults
set_git_remotes_as_authenticated

echo ""
echo "All done. You can now start ZSH."
echo ""
echo "Things to do manually next:"
echo ""
echo "- Install programming language stuff with 'asdf install my_language'"
echo "- Choose a base16 theme by typing 'base16<TAB>'. Don't forget to use a matching theme in vim"
echo "- Install 'gem install invoker'. Run 'invoker setup'. Put 'nameserver 127.0.0.1' on /etc/resolv.conf"
