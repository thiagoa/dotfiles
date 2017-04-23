#!/usr/bin/env zsh
#
# Thiago's Dotfiles setup
#
# Idempotent, smart setup tool: Install dotfiles, vim, bin files, asdf, etc.
# Run as many times as you want.

which git > /dev/null 2> /dev/null

if [ $? -eq 1 ]; then
    echo "ERROR: Yow, I need git... gimme git!"
    exit 1
fi

CURDIR=$(pwd)


function create_directories {
    echo "Creating $HOME/Code directory...\n"

    mkdir -p $HOME/Code/go 2> /dev/null
}


function install_binfiles  {
    echo "Installing bin directory...\n"

    git clone --quiet https://github.com/thiagoa/bin $HOME/bin
}


function install_asdf {
    echo "Installing asdf...\n"

    # Still need to figure out how to get the most up-to-date version...
    git clone --quiet https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0
}


function generate_ssh_key {
    echo "Generating SSH key...\n"

    ssh-keygen -t rsa

    cat $HOME/.ssh/id_rsa.pub 2> /dev/null | xclip -selection c 2> /dev/null
    cat $HOME/.ssh/id_rsa.pub 2> /dev/null | pbcopy 2> /dev/null

    echo "\nYour key has been generated and copied to the clipboard."
    echo "Now go to GitHub.\n"
}


function install_zprezto {
    echo "Installing zprezto...\n"
    git clone --quiet --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    echo ""

    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
}


function install_dotfiles {
    echo "Installing dotfiles..."

    for file in `ls $CURDIR`; do
        if [ $file != 'setup.sh' ]; then
            if [ -f "$HOME/.$file" ] || [ -h "$HOME/.$file" ]; then
                rm $HOME/.$file
            fi
            ln -s $CURDIR/$file $HOME/.$file
        fi
    done
}


function install_vimfiles {
    echo "Installing vimfiles...\n"
    git clone --quiet https://github.com/thiagoa/dotvim $HOME/.vim

    $HOME/.vim/setup.sh
}


function install_base16 {
    echo "Installing base16 themes...\n"
    git clone --quiet https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

    BASE16_SHELL=$HOME/.config/base16-shell/
    eval "$($BASE16_SHELL/profile_helper.sh)"
}


function ask_install_ubuntu_packages {
    echo ""

    if [[ -f /etc/lsb-release ]]; then
        while true; do
            read answer\?"Install Ubuntu packages? (Y/n) "

            case $answer in
                [Yy]*|"") install_ubuntu_packages; break;;
                [Nn]*) break;;
                *) echo "Please answer y or n.";;
            esac
        done
    fi
}


function add_apt_custom_sources {
    echo ""

    while true; do
        read answer\?"Add official git repository? (Y/n) "
        case $answer in
            [Yy]*|"") sudo apt-add-repository ppa:git-core/ppa 2> /dev/null; break;;
            [Nn]*) break;;
            *) echo "Please answer y or n.";;
        esac
    done

    echo ""

    if [ ! -f /etc/apt/sources.list.d/heroku.list ]; then
        sudo sh -c 'echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list'
    fi

    if [ ! -f /etc/apt/sources.list.d/dropbox.list ]; then
        sudo sh -c 'echo "deb http://linux.dropbox.com/ubuntu/ xenial main" > /etc/apt/sources.list.d/dropbox.list' 
    fi

    if [ ! -f /etc/apt/sources.list.d/dropbox.list ]; then
        sudo sh -c 'echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" > /etc/apt/sources.list.d/slack.list'
    fi
}


function check_sudoers {
    echo "\nLet's check if your user is in sudoers...\n"
    sudo -l 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "\nERROR: Please add your user to sudoers and run this script again"
        exit 1
    fi
}


function install_ubuntu_packages {
    check_sudoers

    add_apt_custom_sources

    sudo apt-get update

    sudo apt-get remove vim > /dev/null 2> /dev/null
    sudo apt-get install \
        vim-nox \
        tmux \
        mysql-server \
        libmysqlclient-dev \
        ruby-mysql \
        ruby-build \
        git \
        bsdtar \
        copyq \
        golang \
        redis-server \
        postgresql \
        postgresql-contrib \
        heroku \
        heroku-toolbelt \
        slack \
        dropbox \
        silversearcher-ag \
        exuberant-ctags
}


function set_defaults {
    cat /etc/passwd | grep $USER | grep zsh > /dev/null

    if [ $? -eq 1 ]; then
        echo "\nSetting ZSH as default shell..."

        chsh -s $(which zsh)
    fi
}


function set_git_remotes_as_authenticated {
    cd ~/.vim
    git remote set-url origin git@github.com:thiagoa/dotvim.git

    cd ~/.dotfiles
    git remote set-url origin git@github.com:thiagoa/dotfiles.git

    cd ~/bin
    git remote set-url origin git@github.com:thiagoa/bin.git
}


create_directories

rmdir /bin 2> /dev/null
if [ ! -d $HOME/bin ]; then
    install_binfiles
fi

if [ ! -d $HOME/.asdf ]; then
    install_asdf
fi

if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
    generate_ssh_key
fi

if [ ! -d $HOME/.zprezto ]; then
    install_zprezto
fi

install_dotfiles

if [ ! -d $HOME/.vim ]; then
    install_vimfiles
fi

if [ ! -d $HOME/.config/base16-shell ]; then
    install_base16
fi

ask_install_ubuntu_packages
set_defaults
set_git_remotes_as_authenticated

echo "\nAll done. You can now start ZSH.\n"
echo "Things to do manually next:\n"
echo "- Install rubies with 'asdf install ruby'"
echo "- Manually download elasticsearch if needed"
echo "- Check daemons configuration'"
echo "- Choose a base16 theme by typing 'base16<TAB>'. Don't forget to use a matching theme in vim."
