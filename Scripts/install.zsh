#!/usr/bin/env zsh

local script_dir="$(dirname "$(realpath "$0")")"
if ! source "$script_dir/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

#--------------------#
# pre-install script #
#--------------------#
cat <<"EOF"
                _         _       _ _
 ___ ___ ___   |_|___ ___| |_ ___| | |
| . |  _| -_|  | |   |_ -|  _| .'| | |
|  _|_| |___|  |_|_|_|___|_| |__,|_|_|
|_|

EOF

"$script_dir/install_paru.zsh"

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
"$script_dir/install_packages.zsh" "$script_dir/packages.lst"

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

"$script_dir/install_wallpapers.zsh"
"$script_dir/install_configs.zsh"

#---------------------#
# post-install script #
#---------------------#
cat <<"EOF"

             _      _         _       _ _
 ___ ___ ___| |_   |_|___ ___| |_ ___| | |
| . | . |_ -|  _|  | |   |_ -|  _| .'| | |
|  _|___|___|_|    |_|_|_|___|_| |__,|_|_|
|_|

EOF

"$script_dir/configure_sddm.zsh"
"$script_dir/configure_fcitx5.zsh"
"$script_dir/configure_user.zsh"

#------------------------#
# enable system services #
#------------------------#
cat <<"EOF"

                 _
 ___ ___ ___ _ _|_|___ ___ ___
|_ -| -_|  _| | | |  _| -_|_ -|
|___|___|_|  \_/|_|___|___|___|

EOF

"$script_dir/enable_systemctl.zsh"

echo "\n"
print_log -stat "Installation" "completed"
