#!/bin/bash

function abort() {
  message=$1
  echo "ERROR: $message"
  exit 1
}

function setting_for() {
  local id=$1
  echo "/$(echo $id | sed 's/\./\//g')/"
}
