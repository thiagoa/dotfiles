#!/usr/bin/env bash

if [[ -x "$(which gsettings)" ]]; then
  gnome_scaling_factor="$(gsettings get org.gnome.desktop.interface text-scaling-factor)"

  if [[ "${gnome_scaling_factor}" == "1.8" ]]; then
    export QT_SCALE_FACTOR="0.9"
  fi
fi
