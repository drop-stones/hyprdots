#!/usr/bin/env zsh

scrDir="$(dirname "$(realpath "$0")")"
if ! source "${scrDir}/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

# Add $USER to video group for brightnessctl
if ! id -nG "$USER" | grep -qw "video"; then
  print_log -g "[USERGROUP] " -b " :: " "Adding $USER to the video group..."
  sudo usermod -aG video "$USER"
else
  print_log -y "[USERGROUP] " -b " :: " "$USER is already in the video group"
fi
