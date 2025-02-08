#!/usr/bin/env zsh

scrDir=$(dirname "$(realpath "$0")")
if ! source "${scrDir}/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

if pkg_installed sddm; then
  print_log -c "[DISPLAYMANAGER] " -b "detected :: " "sddm"
  if [ ! -d /etc/sddm.conf.d ]; then
    sudo mkdir -p /etc/sddm.conf.d
  fi
  if [ ! -f /etc/sddm.conf.d/hyprdots_sddm.conf ]; then
    print_log -g "[DISPLAYMANAGER] " -b " :: " "configuring sddm..."
    sudo cp "$scrDir/hyprdots_sddm.conf" /etc/sddm.conf.d/
  else
    print_log -y "[DISPLAYMANAGER] " -b " :: " "sddm is already configured..."
  fi
else
  print_log -y "[DISPLAYMANAGER] " -b " :: " "sddm is not installed..."
fi
