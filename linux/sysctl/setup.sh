#!/bin/bash

config_file="/etc/sysctl.d/99-sysctl.conf"

first_line="vm.dirty_bytes=50331648"
second_line="vm.dirty_background_bytes=16777216"

function setting_exists {
  cat "$config_file" | grep "$1" &> /dev/null
}

function add_line {
  if ! setting_exists "$1"; then
    echo "$1" | sudo tee -a /etc/sysctl.conf > /dev/null
  fi
}

add_line "$first_line"
add_line "$second_line"
