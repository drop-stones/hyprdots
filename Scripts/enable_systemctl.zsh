#!/usr/bin/env zsh

scrDir=$(dirname "$(realpath "$0")")
if ! source "${scrDir}/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

while read -r serviceChk; do

  if [[ $(systemctl list-units --all -t service --full --no-legend "${serviceChk}.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "${serviceChk}.service" ]]; then
    print_log -y "[skip] " -b "active " "Service ${serviceChk}"
  else
    print_log -y "start" "Service ${serviceChk}"
    if [ $flg_DryRun -ne 1 ]; then
      sudo systemctl enable "${serviceChk}.service"
      sudo systemctl start "${serviceChk}.service"
    fi
  fi

done <"${scrDir}/systemctl.lst"
