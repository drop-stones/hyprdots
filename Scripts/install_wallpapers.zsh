#!/usr/bin/env zsh

wallpapersDir="$HOME/.local/share/wallpapers/"

if [ ! -e "$wallpapersDir" ]; then
  git clone https://github.com/drop-stones/wallpapers.git "$wallpapersDir"
  $wallpapersDir/scripts/copy_random_wallpaper.zsh "$HOME/.config/hypr/wallpaper.jpg"
fi
