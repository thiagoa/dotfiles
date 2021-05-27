#!/bin/bash

pip_autokey_model="/home/thiago/.local/lib/python3.7/site-packages/autokey/model.py"
package_autokey_model="/usr/lib/python3/dist-packages/autokey/model.py"

if [[ -f "$package_autokey_model" ]]; then
  old_code="return bool(r.match(window_info.wm_title)) or bool(r.match(window_info.wm_class))"
  new_code="return bool(r.match(window_info.wm_class))"

  sudo sed -i "s/$old_code/$new_code/g" $package_autokey_model

  echo 'Autokey has been patched'
else
  if [[ "$(uname)" = 'Linux' ]]; then
    1>&2 echo 'ERROR: Autokey file was not found. Has it been installed?'
  fi
fi

source_config_dir="$HOME/OneDrive/Linux/autokey-data"
dest_config_dir="$HOME/.config/autokey/data"

if [[ -d $source_config_dir ]]; then
   mkdir -p $dest_dir 2> /dev/null

   if [[ -d $dest_config_dir ]]; then
     rm -rf $dest_config_dir
   fi

   ln -sfn $source_config_dir $dest_config_dir
else
   echo "Autokey OneDrive dir not found! Skipping data linking..."
fi
