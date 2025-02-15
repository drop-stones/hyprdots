#!/usr/bin/env zsh

local script_dir=$(dirname "$(realpath "$0")")
local package_list="$1"
if ! source "$script_dir/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

local arch_packages=()
local aur_packages=()

while read -r package; do
  local package="${package// /}"
  if [ -z "$package" ]; then
    continue
  fi

  if package_installed "$package"; then
    print_log -y "[skip] " "$package"
  elif package_available "$package"; then
    repo=$(pacman -Si "$package" | awk -F ': ' '/Repository / {print $2}')
    print_log -b "[queue] " -g "$repo" -b "::" "$package"
    arch_packages+=("$package")
  elif aur_available "$package"; then
    print_log -b "[queue] " -g "aur" -b "::" "$package"
    aur_packages+=("$package")
  else
    print_log -r "[error] " "unknown package $package..."
  fi
done < <(cut -d '#' -f 1 "$package_list")

if [[ ${#arch_packages[@]} -gt 0 ]]; then
  print_log -b "[install] " "arch packages..."
  sudo pacman -S --noconfirm "${arch_packages[@]}"
fi

if [[ ${#aur_packages[@]} -gt 0 ]]; then
  print_log -b "[install] " "aur packages..."
  paru -S --noconfirm "${aur_packages[@]}"
fi
