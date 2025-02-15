##############################################
# Print Utilities
##############################################

function print_log() {
  declare -A decorations=(
    [-r]="\e[31m{}\e[0m" # Red
    [-g]="\e[32m{}\e[0m" # Green
    [-y]="\e[33m{}\e[0m" # Yellow
    [-b]="\e[34m{}\e[0m" # Blue
    [-m]="\e[35m{}\e[0m" # Magenta
    [-c]="\e[36m{}\e[0m" # Blue
    [-w]="\e[37m{}\e[0m" # White
    [-stat]="\e[4;30;46m {} \e[0m :: "
    [-crit]="\e[30;41m {} \e[0m :: "
    [-warn]="WARNING :: \e[30;43m {} \e[0m :: "
    [-sec]="\e[32m[{}] \e[0m"
    [-err]="ERROR :: \e[4;31m{} \e[0m"
  )

  while (("$#")); do
    if [[ ${decorations[$1]} ]]; then
      echo -ne "${decorations[$1]//\{\}/$2}"
      shift 2
    else
      echo -ne "$1"
      shift
    fi
  done
  echo "" # new line
}

##############################################
# pacman/paru
##############################################

function package_installed() {
  local package=$1
  if pacman -Qi "$package" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

function package_available() {
  local package=$1

  if pacman -Si "$package" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

function aur_available() {
  local package=$1

  if paru -Si "$package" &>/dev/null; then
    return 0
  else
    return 1
  fi
}
