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
  echo "Installing bin directory...\n"

  if [[ ! -L ~/bin ]] && [[ -d ~/bin ]]; then
    dest="$HOME/.bin_backup"
    mv $HOME/bin $dest
    echo "Moved current bin directory to $dest"
  else
    rm -f ~/bin
  fi

  ln -s $INSTALL_DIR/bin $HOME/bin
}

function install_asdf {
  if [[ -d $HOME/.asdf ]]; then return; fi

  echo "Installing asdf...\n"

  # Still need to figure out how to get the most up-to-date version...
  git clone -q https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.3.0 > /dev/null
}

function generate_ssh_key {
  if [[ -f $HOME/.ssh/id_rsa.pub ]]; then return; fi

  echo "Generating SSH key...\n"

  ssh-keygen -t rsa

  echo "\nYour key has been generated. Now go to GitHub."
}

function install_zprezto {
  if [[ -d $HOME/.zprezto ]]; then return; fi

  echo "Installing zprezto..."

  git clone -q --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" > /dev/null 2>&1

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

function install_fzf {
  echo "Installing fzf..."

  if [[ ! -d ~/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
  fi
}

function install_vimfiles {
  if [[ -d $HOME/.vim ]]; then return; fi

  echo "Installing vimfiles...\n"

  git clone -q https://github.com/thiagoa/dotvim $HOME/.vim

  $HOME/.vim/setup.sh
}

function install_emacsfiles {
  if [[ -d $HOME/.emacs.d ]]; then return; fi

  echo "Installing Emacs files...\n"

  git clone -q https://github.com/thiagoa/dotemacs $HOME/.emacs.d
}

function install_base16 {
  if [[ -d $HOME/.config/base16-shell ]]; then return; fi

  echo "\nInstalling base16 themes..."

  git clone -q https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell

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
  local shell_is_already_zsh=$(cat /etc/passwd | grep -q $USER | grep -q zsh)

  if ! $shell_is_already_zsh; then
    local zshpath=$(which zsh)
    local shellspath=/etc/shells

    echo "\nSetting ZSH as default shell..."

    if [[ -f $shellspath ]] && ! grep -q $zshpath $shellspath; then
      echo $zshpath | sudo tee -a $shellspath > /dev/null
    fi

    chsh -s $zshpath
  fi
}

function install_linux_config {
  if [[ "$(uname)" == "Linux" ]]; then
    echo "Installing Linux-specific config..."

    $INSTALL_DIR/linux/udev/setup.sh
    $INSTALL_DIR/linux/autokey/setup.sh
    $INSTALL_DIR/linux/gnome-shortcuts/setup.sh
    $INSTALL_DIR/linux/gnome-settings/install_crontab
    $INSTALL_DIR/linux/gnome-autostart/setup.sh
    $INSTALL_DIR/linux/veracrypt/setup.sh
    $INSTALL_DIR/linux/ulauncher/setup.sh
    $INSTALL_DIR/linux/packages/setup.sh
    $INSTALL_DIR/linux/xkeysnail/setup.sh
    $INSTALL_DIR/linux/devilspie2/setup.sh
    $INSTALL_DIR/linux/system-sleep/setup.sh
    $INSTALL_DIR/linux/clipboard-indicator/setup.sh
  fi
}

function install_mac_config {
  if [[ "$(uname)" == "Darwin" ]]; then
    rm -rf ~/.config/karabiner
    ln -s $INSTALL_DIR/mac/karabiner ~/.config/karabiner
  fi
}

function set_git_remotes_as_authenticated {
  cd $HOME/.vim && git remote set-url origin git@github.com:thiagoa/dotvim.git
  cd $INSTALL_DIR && git remote set-url origin git@github.com:thiagoa/dotfiles.git
  cd $HOME/bin && git remote set-url origin git@github.com:thiagoa/bin.git
}

create_directories
install_binfiles
install_asdf
generate_ssh_key
install_zprezto
install_dotfiles
install_fzf
install_vimfiles
install_emacsfiles
install_base16
set_defaults
install_linux_config
install_mac_config
set_git_remotes_as_authenticated

echo ""
echo "All done. You can now start ZSH."
echo ""
echo "Things to do manually next:"
echo ""
echo "- Install programming language stuff with 'asdf install my_language'"
echo "- Choose a base16 theme by typing 'base16<TAB>'. Don't forget to use a matching theme in vim"
