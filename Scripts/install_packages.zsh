#!/usr/bin/env zsh

scrDir=$(dirname "$(realpath "$0")")
listPkg="$1"
if ! source "${scrDir}/functions.zsh"; then
  echo "Error: unable to source functions.zsh..."
  exit 1
fi

while read -r pkg deps; do
  pkg="${pkg// /}"
  if [ -z "${pkg}" ]; then
    continue
  fi

  if [ -n "${deps}" ]; then
    deps="${deps%"${deps##*[![:space:]]}"}"
    while read -r cdep; do
      pass=$(cut -d '#' -f 1 "${listPkg}" | awk -F '|' -v chk="${cdep}" '{if($1 == chk) {print 1;exit}}')
      if [ -z "${pass}" ]; then
        if pkg_installed "${cdep}"; then
          pass=1
        else
          break
        fi
      fi
    done < <(xargs -n1 <<<"${deps}")

    if [[ ${pass} -ne 1 ]]; then
      print_log -warn "missing" "dependency [ ${deps} ] for ${pkg}..."
      continue
    fi
  fi

  if pkg_installed "${pkg}"; then
    print_log -y "[skip] " "${pkg}"
  elif pkg_available "${pkg}"; then
    repo=$(pacman -Si "${pkg}" | awk -F ': ' '/Repository / {print $2}')
    print_log -b "[queue] " -g "${repo}" -b "::" "${pkg}"
    archPkg+=("${pkg}")
  elif aur_available "${pkg}"; then
    print_log -b "[queue] " -g "aur" -b "::" "${pkg}"
    aurhPkg+=("${pkg}")
  else
    print_log -r "[error] " "unknown package ${pkg}..."
  fi
done < <(cut -d '#' -f 1 "${listPkg}")

IFS=${ofs}

if [[ ${#archPkg[@]} -gt 0 ]]; then
  print_log -b "[install] " "arch packages..."
  sudo pacman --no-confirm -S "${archPkg[@]}"
fi

if [[ ${#aurhPkg[@]} -gt 0 ]]; then
  print_log -b "[install] " "aur packages..."
  paru -S --noconfirm "${aurhPkg[@]}"
fi
