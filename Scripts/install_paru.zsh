#!/usr/bin/env zsh

local script_dir=$(dirname "$(realpath "$0")")
if ! source "$script_dir/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

if package_installed paru; then
  print_log -y "[skip] " "paru"
  exit 0
fi

if package_installed git; then
  git clone "https://aur.archlinux.org/paru.git" "$HOME/paru"
else
  print_log -r "AUR" -stat "missing" "git dependency..."
  exit 1
fi

cd "$HOME/paru" || exit
if makepkg "$use_default" -si; then
  print_log -sec "AUR" -stat "installed" "paru aur helper..."
else
  print_log -r "AUR" -stat "failed" "paru installation failed..."
  echo "paru installation failed..."
  exit 1
fi

if [ -d "$HOME/paru" ]; then
  print_log -sec "AUR" -stat "remove" "paru directory..."
  rm -rf "$HOME/paru"
fi
