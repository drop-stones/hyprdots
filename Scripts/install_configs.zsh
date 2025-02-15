#!/usr/bin/env zsh

# Copy Configs/* to $HOME

local script_dir="$(dirname "$(realpath "$0")")"
local source_dir="$script_dir/../Configs"

find "$source_dir" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
  target_dir="${dir/$source_dir/$HOME}" # replace $source_dir with $HOME
  mkdir -p "$target_dir"
  cp -r "$dir"/* "$target_dir"
done
