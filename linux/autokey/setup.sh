#!/bin/bash

autokey_config_dir="$HOME/.config/autokey/data"
pip_autokey_model="/home/thiago/.local/lib/python3.7/site-packages/autokey/model.py"
package_autokey_model="/usr/lib/python3/dist-packages/autokey/model.py"

if [[ -f "$package_autokey_model" ]]; then
  old_code="return bool(r.match(window_info.wm_title)) or bool(r.match(window_info.wm_class))"
  new_code="return bool(r.match(window_info.wm_class))"

  sed -i "s/$old_code/$new_code/g" $package_autokey_model

  echo 'Autokey has been patched'
else
  if [[ "$(uname)" = 'Linux' ]]; then
    1>&2 echo 'ERROR: Autokey file was not found. Has it been installed?'
  fi
fi

if [[ "$(uname)" = "Linux" ]]; then
   mkdir -p $autokey_config_dir 2> /dev/null
   ln -fs $HOME/.dotfiles/autokey/snippets/* $autokey_config_dir
fi
