#!/usr/bin/env zsh

local script_dir=$(dirname "$(realpath "$0")")
if ! source "$script_dir/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

function start_service() {
  local unit_type="$1" # "service" or "timer"
  local file="$2"      # List file

  while read -r service; do
    local service="${service// /}"
    if [ -z "$service" ]; then
      continue
    fi

    if [[ $(systemctl list-units --all -t "$unit_type" --full --no-legend "$service.$unit_type" | sed 's/^\s*//g' | cut -f1 -d' ') == "${service}.$unit_type" ]]; then
      print_log -y "[skip] " -b "active " "Service $service.$unit_type"
    else
      print_log -y "start " "Service $service.$unit_type"
      sudo systemctl enable "$service.$unit_type"
      sudo systemctl start "$service.$unit_type"
    fi
  done <"$file"
}

start_service "service" "$script_dir/systemctl.lst"
start_service "timer" "$script_dir/systemctl_timer.lst"
