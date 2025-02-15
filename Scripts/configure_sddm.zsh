#!/usr/bin/env zsh

local script_dir="$(dirname "$(realpath "$0")")"
if ! source "$script_dir/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

if package_installed sddm; then
  print_log -c "[DISPLAYMANAGER] " -b "detected :: " "sddm"
  if [ ! -d /etc/sddm.conf.d ]; then
    sudo mkdir -p /etc/sddm.conf.d
  fi
  if [ ! -f /etc/sddm.conf.d/hyprdots_sddm.conf ]; then
    print_log -g "[DISPLAYMANAGER] " -b " :: " "configuring sddm..."
    sudo cp "$script_dir/hyprdots_sddm.conf" /etc/sddm.conf.d/
  else
    print_log -y "[DISPLAYMANAGER] " -b " :: " "sddm is already configured..."
  fi
else
  print_log -y "[DISPLAYMANAGER] " -b " :: " "sddm is not installed..."
fi
