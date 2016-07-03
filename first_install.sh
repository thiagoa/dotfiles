#!/usr/bin/env zsh

CURDIR=$(pwd)


function create_directories {
    echo "Creating $HOME/Code directory...\n"

    mkdir $HOME/Code 2> /dev/null
}


function install_rbenv {
    echo "Installing rbenv...\n"

    RBENV_ROOT="$HOME/.rbenv"
    git clone --quiet https://github.com/rbenv/rbenv.git $RBENV_ROOT
    cd $RBENV_ROOT && src/configure && make -C src

    echo "\nInstalling rbenv plugins...\n"

    git clone --quiet https://github.com/carsomyr/rbenv-bundler.git $RBENV_ROOT/plugins/bundler
    git clone --quiet https://github.com/rbenv/rbenv-default-gems.git $RBENV_ROOT/plugins/rbenv-default-gems
    git clone --quiet https://github.com/rkh/rbenv-whatis.git $RBENV_ROOT/plugins/rbenv-whatis
    git clone --quiet https://github.com/rkh/rbenv-use.git $RBENV_ROOT/plugins/rbenv-use
    git clone --quiet https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build
}


function generate_ssh_key {
    echo "Generating SSH key...\n"

    ssh-keygen -t rsa

    cat $HOME/.ssh/id_rsa.pub 2> /dev/null | xclip -selection c 2> /dev/null
    cat $HOME/.ssh/id_rsa.pub 2> /dev/null | pbcopy 2> /dev/null

    echo "\nYour key has been generated and copied to the clipboard."
    echo "Now go to GitHub.\n"

    echo ""
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
    echo "Installing dotfiles...\n"
    $CURDIR/setup.sh
}


function install_vimfiles {
    echo "Installing vimfiles...\n"
    git clone --quiet https://github.com/thiagoa/dotvim $HOME/.vim

    $HOME/.vim/setup.sh
}

function ask_install_linux_packages {
    echo ""

    if [ -x /bin/uname ] && uname | grep "Linux" > /dev/null; then
        while true; do
            read answer\?"Install Linux packages? (Y/n) "

            case $answer in
                [Yy]*|"") install_linux_packages; break;;
                [Nn]*) break;;
                *) echo "Please answer y or n.";;
            esac
        done
    fi
}

function install_linux_packages {
    echo ""
    echo "Let's check if your user is in sudoers...\n"
    sudo -l 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "\nERROR: Please add your user to sudoers and run this script again"
        exit 1
    fi

    while true; do
        echo ""
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
        silversearcher-ag
}


function set_defaults {
    echo "\nSetting ZSH as default shell..."

    chsh -s $(which zsh)
}

function set_git_remotes_as_authenticated {
    cd ~/.vim
    git remote set-url origin git@github.com:thiagoa/dotvim.git

    cd ~/.dotfiles
    git remote set-url origin git@github.com:thiagoa/dotfiles.git
}


create_directories

if [ ! -d $HOME/.rbenv ]; then
    install_rbenv
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

ask_install_linux_packages

set_defaults

set_git_remotes_as_authenticated

echo "\nAll done. You can now start ZSH."
