#!/usr/bin/env zsh

scrDir="$(dirname "$(realpath "$0")")"
if ! source "${scrDir}/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

#------------#
# installing #
#------------#
cat <<"EOF"

 _         _       _ _ _
|_|___ ___| |_ ___| | |_|___ ___
| |   |_ -|  _| .'| | | |   | . |
|_|_|_|___|_| |__,|_|_|_|_|_|_  |
                            |___|

EOF

#--------------------------------#
# install packages from the list #
#--------------------------------#
"${scrDir}/install_packages.zsh" "${scrDir}/packages.lst"

#---------------------------#
# restore my custom configs #
#---------------------------#
cat <<"EOF"

             _           _
 ___ ___ ___| |_ ___ ___|_|___ ___
|  _| -_|_ -|  _| . |  _| |   | . |
|_| |___|___|_| |___|_| |_|_|_|_  |
                              |___|

EOF

"${scrDir}/install_configs.zsh"

#------------------------#
# enable system services #
#------------------------#
cat <<"EOF"

                 _
 ___ ___ ___ _ _|_|___ ___ ___
|_ -| -_|  _| | | |  _| -_|_ -|
|___|___|_|  \_/|_|___|___|___|

EOF

"${scrDir}/enable_systemctl.zsh"

echo "\n"
print_log -stat "Installation" "completed"
