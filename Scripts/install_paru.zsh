#!/usr/bin/env bash

scrDir=$(dirname "$(realpath "$0")")
if ! source "${scrDir}/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

aurhlpr="paru"

if pkg_installed $aurhlpr; then
  print_log -y "[skip] " "${aurhlpr}"
  exit 0
fi

if pkg_installed git; then
  git clone "https://aur.archlinux.org/${aurhlpr}.git" "$HOME/${aurhlpr}"
else
  print_log -r "AUR" -stat "missing" "git dependency..."
  exit 1
fi

cd "$HOME/${aurhlpr}" || exit
if makepkg "${use_default}" -si; then
  print_log -sec "AUR" -stat "installed" "${aurhlpr} aur helper..."
else
  print_log -r "AUR" -stat "failed" "${aurhlpr} installation failed..."
  echo "${aurhlpr} installation failed..."
  exit 1
fi

if [ -d "$HOME/$aurhlpr" ]; then
  print_log -sec "AUR" -stat "remove" "$aurhlpr directory..."
  rm -rf "$HOME/${aurhlpr}"
fi
