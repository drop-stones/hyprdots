#!/usr/bin/env zsh

scrDir="$(dirname "$(realpath "$0")")"
if ! source "${scrDir}/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

fcitx5_theme_dir="$HOME/.local/share/fcitx5/themes/catppuccin-mocha-mauve"
fcitx5_theme_url="https://raw.github.com/catppuccin/fcitx5/main/src/catppuccin-mocha-mauve"
if [ ! -e "$fcitx5_theme_dir" ]; then
  print_log -g "[fcitx5] " -b " :: " "installing catppuccin-mocha-mauve..."
  mkdir -p "$fcitx5_theme_dir"
  wget "$fcitx5_theme_url"/arrow.png -P $fcitx5_theme_dir
  wget "$fcitx5_theme_url"/radio.png -P $fcitx5_theme_dir
  wget "$fcitx5_theme_url"/theme.conf -P $fcitx5_theme_dir
else
  print_log -y "[fcitx5] " -b " :: " "catppuccin-mocha-mauve is already installed"
fi
