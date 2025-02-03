#!/usr/bin/env zsh

# Copy Configs/* to $HOME

scrDir="$(dirname "$(realpath "$0")")"
srcDir="$scrDir/../Configs"

find "$srcDir" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
  target_dir="${dir/$srcDir/$HOME}" # replace $srcDir with $HOME
  mkdir -p "$target_dir"
  cp -r "$dir"/* "$target_dir"
done
