#!/usr/bin/env zsh

# Copy systemctl/* to /etc/

local script_dir="$(dirname "$(realpath "$0")")"
local source_dir="$script_dir/../systemctl"

sudo cp "$source_dir/reflector.conf" /etc/xdg/reflector/reflector.conf
