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

function display_prerequisites {
  echo "Before running this script, make sure that:"
  echo
  echo "- Google Chrome is installed (preferrably with sync)"
  echo "- Dropbox and insync are installed and synced"
  echo "- You act on the GitHub ssh instructions that will be displayed"
  echo

  if read -q "choice?Do you wish to continue (y/n): "; then
    echo "\n"
    return 0
  else
    echo "\n\nBye!"
    exit 0
  fi
}

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
  git clone -q https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1 > /dev/null
}

function has_asdf_plugin {
  local plugin=$1

  if asdf plugin-list | grep $1 > /dev/null; then
    return 0
  else
    return 1
  fi
}

function add_plugin {
  local plugin=$1
  local repo=$2

  if ! has_asdf_plugin $1; then
    asdf plugin-add $1 https://github.com/$repo
  fi
}

function install_asdf_plugins {
  echo "Installing asdf plugins...\n"

  add_plugin nodejs asdf-vm/asdf-nodejs.git
  add_plugin ruby asdf-vm/asdf-ruby.git
  add_plugin java halcyon/asdf-java.git
  add_plugin lein miorimmax/asdf-lein.git
  add_plugin yarn twuni/asdf-yarn.git
}

function setup_ssh {
  if [[ ! -f $HOME/.ssh/id_rsa.pub ]]; then
    echo "Generating SSH key...\n"

    ssh-keygen -t rsa

    echo "\nYour key has been generated. Now go to GitHub."
    echo "Press any key to continue"
    while [ true ] ; do
      read -t 3 -n 1
      if [ $? = 0 ] ; then
        break
      fi
    done
  fi

  if [[ -f $HOME/Dropbox/Config/ssh_config ]]; then
    ln -sfn $HOME/Dropbox/Config/ssh_config $HOME/.ssh/config
  fi

  if [[ -f $HOME/Dropbox/Config/indicator-stickynotes ]]; then
    ln -sfn $HOME/Dropbox/Config/indicator-stickynotes $HOME/.config/indicator-stickynotes
  fi
}

function setup_secrets {
  if [[ -f $HOME/Dropbox/Config/secrets ]]; then
    ln -sfn $HOME/Dropbox/Config/secrets $HOME/.secrets
  fi
}

function install_zprezto {
  if [[ -d $HOME/.zprezto ]]; then return; fi

  echo "Installing zprezto..."

  git clone -q --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" > /dev/null 2>&1

  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done

  echo 'Please, log in with zsh and run this script again'
  exit
}

function install_dotfiles {
  echo "Installing dotfiles..."

  for file in ${INSTALL_DIR}/^(setup.sh|README.md)(.N:t); do
    if [ -f "$HOME/.$file" ] || [ -h "$HOME/.$file" ]; then
      rm $HOME/.$file
    fi

    ln -s $INSTALL_DIR/$file $HOME/.$file
  done

  $INSTALL_DIR/other/setup.sh
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
  local emacs_custom_file="$HOME/Dropbox/Config/emacs.custom.el"

  if [[ -f $emacs_custom_file ]]; then
    ln -sfn $emacs_custom_file $HOME/.emacs.custom.el
  fi

  if [[ -f $HOME/.emacs.d/init.el ]]; then
      return
  else
      if [[ -d ~/.emacs.d ]]; then
        echo "Backing up current .emacs.d to ~/.emacs.d.backup..."

        rm -rf $HOME/.emacs.d.backup
        mv $HOME~/.emacs.d $HOME~/.emacs.d.backup
      fi
  fi

  echo "Installing Emacs files...\n"

  git clone -q git@github.com:thiagoa/dotemacs $HOME/.emacs.d
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

  local zshpath=$(which zsh)
  local shellspath=/etc/shells

  echo "\nSetting ZSH as default shell..."

  if [[ -f $shellspath ]] && ! grep -q $zshpath $shellspath; then
    echo $zshpath | sudo tee -a $shellspath > /dev/null
  fi

  chsh -s $zshpath
}

function install_linux_config {
  if [[ "$(uname)" == "Linux" ]]; then
    echo "Installing Linux-specific config..."

    $INSTALL_DIR/linux/packages/setup.sh
    $INSTALL_DIR/linux/packages/setup_emacs.sh
    $INSTALL_DIR/linux/packages/setup_gnome_sushi.sh
    $INSTALL_DIR/linux/packages/setup_brotab.sh
    $INSTALL_DIR/linux/amdgpu/setup.sh
    $INSTALL_DIR/linux/sudoers/setup.sh
    $INSTALL_DIR/linux/udev/setup.sh
    $INSTALL_DIR/linux/autokey/setup.sh
    $INSTALL_DIR/linux/gnome-shortcuts/setup.sh
    $INSTALL_DIR/linux/gnome-settings/install-crontab
    $INSTALL_DIR/linux/gnome-autostart/setup.sh
    $INSTALL_DIR/linux/veracrypt/setup.sh
    $INSTALL_DIR/linux/ulauncher/setup.sh
    $INSTALL_DIR/linux/xkeysnail/setup.sh
    $INSTALL_DIR/linux/devilspie2/setup.sh
    $INSTALL_DIR/linux/system-sleep/setup.sh
    $INSTALL_DIR/linux/clipboard-indicator/setup.sh
    $INSTALL_DIR/linux/fix-cedilla/setup.sh
    $INSTALL_DIR/linux/sysctl/setup.sh
    $INSTALL_DIR/linux/nautilus/setup.sh
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
}

# TODO: Refactor later
function setup_mac {
  if [[ ! -x "$(which brew)" ]]; then
      echo "Installing homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  if [[ ! -x "$(which pip3)" ]]; then
      echo "Installing Python..."
      brew install python
  fi

  if ! $(brew list zsh > /dev/null 2>&1); then
      echo "Installing zsh..."
      brew install zsh
      set_defaults

      echo "Please restart your shell and run setup again"
      exit 0
  fi

  if ! $(brew list neovim > /dev/null 2>&1); then
      echo "Installing neovim..."
      brew install neovim
  fi

  if ! $(brew list rg > /dev/null 2>&1); then
      echo "Installing rg..."
      brew install rg
  fi

  if ! $(brew list ag > /dev/null 2>&1); then
      echo "Installing ag..."
      brew install ag
  fi
}

if [[ "$(uname -s)" == "Darwin" ]]; then
    setup_mac
fi

display_prerequisites
create_directories
set_defaults
install_zprezto
install_binfiles
install_asdf
install_asdf_plugins
setup_ssh
setup_secrets
install_dotfiles
install_fzf
install_vimfiles
install_emacsfiles
install_base16
install_linux_config
install_mac_config
set_git_remotes_as_authenticated

echo ""
echo "All done. You can now start ZSH."
echo ""
echo "Things to do manually next:"
echo ""
echo "- If this is a new install, log out and re-login to effect changes (inc. docker)"
echo "- Add online accounts to Gnome"
echo "- Add Mailspring accounts and signatures"
echo "- Install programming language stuff with 'asdf install my_language'"
echo "- Install veracrypt GUI and console: https://www.veracrypt.fr/en/Downloads.html"
echo "- Sync JetBrains appse (if any) settings"
echo "- Download and install Google Chrome, 1Password for Linux, Dropbox, Veracrypt, Mailspring, VS Code, warsaw, clockify, JetBrains Mono"
echo "- Sync Gnome Shell extensions through Google Chrome (enable syncing and it will find the backup)"
echo "- Sync VS Code settings (first install Settings sync extension)"
echo "- Restart Chrome for brotab (and others) to work"
