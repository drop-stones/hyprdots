function pkg_installed() {
  local pkgIn=$1
  if pacman -Qi "${pkgIn}" &>/dev/null; then
    return 0
  elif command -v "${pkgIn}" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

function pkg_available() {
  local pkgIn=$1

  if pacman -Si "${pkgIn}" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

function aur_available() {
  local pkgIn=$1

  if ${aurhlpr} -Si "${PkgIn}" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

function print_log() {
  while (("$#")); do
    case "$1" in
    -r | +r)
      echo -ne "\e[31m$2\e[0m"
      shift 2
      ;; # Red
    -g | +g)
      echo -ne "\e[32m$2\e[0m"
      shift 2
      ;; # Green
    -y | +y)
      echo -ne "\e[33m$2\e[0m"
      shift 2
      ;; # Yellow
    -b | +b)
      echo -ne "\e[34m$2\e[0m"
      shift 2
      ;; # Blue
    -m | +m)
      echo -ne "\e[35m$2\e[0m"
      shift 2
      ;; # Magenta
    -c | +c)
      echo -ne "\e[36m$2\e[0m"
      shift 2
      ;; # Cyan
    -wt | +w)
      echo -ne "\e[37m$2\e[0m"
      shift 2
      ;; # White
    -n | +n)
      echo -ne "\e[96m$2\e[0m"
      shift 2
      ;; # Neon
    -stat)
      echo -ne "\e[4;30;46m $2 \e[0m :: "
      shift 2
      ;; # status
    -crit)
      echo -ne "\e[30;41m $2 \e[0m :: "
      shift 2
      ;; # critical
    -warn)
      echo -ne "WARNING :: \e[30;43m $2 \e[0m :: "
      shift 2
      ;; # warning
    +)
      echo -ne "\e[38;5;$2m$3\e[0m"
      shift 3
      ;; # Set color manually
    -sec)
      echo -ne "\e[32m[$2] \e[0m"
      shift 2
      ;; # section use for logs
    -err)
      echo -ne "ERROR :: \e[4;31m$2 \e[0m"
      shift 2
      ;; #error
    *)
      echo -ne "$1"
      shift
      ;;
    esac
  done
  echo ""
}
