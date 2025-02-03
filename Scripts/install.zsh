#!/usr/bin/env zsh

scrDir="$(dirname "$(realpath "$0")")"

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
