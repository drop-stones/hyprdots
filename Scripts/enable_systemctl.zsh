#!/usr/bin/env zsh

local script_dir=$(dirname "$(realpath "$0")")
if ! source "$script_dir/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

while read -r service; do
  local service="${service// /}"
  if [ -z "$service" ]; then
    continue
  fi

  if [[ $(systemctl list-units --all -t service --full --no-legend "$service.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "${service}.service" ]]; then
    print_log -y "[skip] " -b "active " "Service $service"
  else
    print_log -y "start" "Service $service"
    sudo systemctl enable "$service.service"
    sudo systemctl start "$service.service"
  fi
done <"$script_dir/systemctl.lst"
