#!/usr/bin/env zsh

local wallpapers_dir="$HOME/.local/share/wallpapers/"

if [ ! -e "$wallpapers_dir" ]; then
  git clone https://github.com/drop-stones/wallpapers.git "$wallpapers_dir"
  $wallpapers_dir/scripts/copy_random_wallpaper.zsh "$HOME/.config/hypr/wallpaper.jpg"
fi
