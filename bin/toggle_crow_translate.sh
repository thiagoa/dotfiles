#!/bin/bash

command="crow"

function is_running {
  $(pgrep "^$command$" > /dev/null 2>&1)
}

function show {
  dbus-send \
    --type=method_call \
    --dest=io.crow_translate.CrowTranslate \
    /io/crow_translate/CrowTranslate/MainWindow \
    io.crow_translate.CrowTranslate.MainWindow.open
}

function hide {
  winid=$(wmctrl -l -x | awk '{print $1 " " $3}' | grep 'crow.Crow' | awk '{print $1}')
  [[ -z "$winid" ]] && return 1
  wmctrl -i -c $winid
}

function launch {
  crow &
  until pidof $command; do
    sleep 0.1
  done
  sleep 0.5
  show
}

if ! is_running; then
  launch
elif ! hide; then
  show
fi
